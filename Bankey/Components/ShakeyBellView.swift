//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Owais Kreifeh on 19/06/2022.
//

import Foundation
import UIKit

class ShakeyBellView: UIView {
    
    let imageView = UIImageView();
    var tapAction: (() -> Void)? = nil;
    let buttonView = UIButton()
    let buttonHeight: CGFloat = 16

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 64, height: 64)
    }
}

extension ShakeyBellView {
    
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(singleTap)
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal)
        imageView.image = image;
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemRed
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonView.layer.cornerRadius = buttonHeight/2
        buttonView.setTitle("9", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
        
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(buttonView)

        NSLayoutConstraint.activate([
            // Image
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            // Button
            buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            buttonView.widthAnchor.constraint(equalToConstant: 16),
            buttonView.heightAnchor.constraint(equalToConstant: 16),

        ])
    }
}

// MARK: - Actions
extension ShakeyBellView {
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        print("shakey");
        shakeWith(duration: 1.0, angle: .pi/12, yOffset: 0)
        guard let action = tapAction else { return }
        action();
    }
}


// MARK: - Animations
extension ShakeyBellView {
    func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6;
        let frameDuration: Double = Double(1 / numberOfFrames);
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset));
        
        let animations = {
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle);
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 1, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle);
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle);
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle);
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle);
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration * 5, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, animations: animations);
        
    }
}

