//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import Foundation
import UIKit


class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView();
    let imageView = UIImageView();
    let label = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        style();
        layout();
    }
    
}

extension OnboardingViewController {
    func style(){
        
        view.backgroundColor = .systemBackground;
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center;
        label.adjustsFontForContentSizeCategory = true;
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(imageView);
        stackView.addArrangedSubview(label);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Stack View
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
