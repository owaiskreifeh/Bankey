//
//  LogoutViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import Foundation
import UIKit

protocol LogoutViewControllerDelegate: AnyObject {
    func didLogout();
}

class LogoutViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    let logoutButton = UIButton(type: .roundedRect)
    let onboardingButton = UIButton(configuration: .filled())
    
    weak var delegate: LogoutViewControllerDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
    }
    
}

extension LogoutViewController {
    
    func setup(){
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
        onboardingButton.addTarget(self, action: #selector(onboardingTapped), for: .primaryActionTriggered);
        
        navigationController?.navigationBar.backgroundColor = .systemBackground;
    }
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Bye Bye 😉";
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false;
        logoutButton.setTitle("Logout", for: []);
        
        onboardingButton.setTitle("Show onboarding", for: [])
        
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        stackView.addArrangedSubview(logoutButton);
        stackView.addArrangedSubview(onboardingButton);

        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}


// MARK: - Actions
extension LogoutViewController {
    @objc func logoutTapped(){
        delegate?.didLogout()
    }
    @objc func onboardingTapped(){
        print("Showing onboarding")
        navigationController?.pushViewController(OnboardingContainerViewController(), animated: true)
//        present(OnboardingContainerViewController(), animated: true)
    }
}
