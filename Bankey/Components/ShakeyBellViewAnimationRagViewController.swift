//
//  ShakeyBellViewAnimationRag.swift
//  Bankey
//
//  Created by Owais Kreifeh on 19/06/2022.
//

import UIKit;

class ShakeyBellViewAnimationRagViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    
    let shakeyBellView = ShakeyBellView();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        style();
        layout();
    }
    
}

extension ShakeyBellViewAnimationRagViewController {
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "ShakeyBell Animation Rag";
        label.font = UIFont.preferredFont(forTextStyle: .title1);
        
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        stackView.addArrangedSubview(shakeyBellView);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
