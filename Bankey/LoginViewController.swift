//
//  ViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin();
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel();
    let subtitleLabel = UILabel();

    let loginView = LoginView();
    let loginButton = UIButton(type: .system);
    let errorLabel = UILabel();
    
    var username: String? { loginView.usernameTextField.text }
    var password: String? { loginView.passwordTextField.text }
        
    weak var delegate: LoginViewControllerDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style();
        layout();
        
    }

}

// MARK: Render
extension LoginViewController {
    
    func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Bankey";
        titleLabel.font = UIFont.systemFont(ofSize: 8 * 4);
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        subtitleLabel.text = "Go do somethings with your bank here is a long text, really really long text you can't fit in 1 line";
        subtitleLabel.font = UIFont.systemFont(ofSize: 8 * 2);
        subtitleLabel.textColor = .systemGray;
        subtitleLabel.numberOfLines = 0;
        subtitleLabel.textAlignment = .center
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.configuration = .filled();
        loginButton.configuration?.imagePadding = 8;
        loginButton.setTitle("Signup", for: .normal);
        loginButton.setImage(.init(systemName: "signature"), for: []);
        loginButton.addTarget(self, action: #selector(singupTapped), for: .primaryActionTriggered);
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false;
        errorLabel.textAlignment = .center;
        errorLabel.textColor = .systemRed;
        errorLabel.numberOfLines = 0;
        errorLabel.isHidden = true;
    }
    
    func layout() {
        view.addSubview(titleLabel);
        view.addSubview(subtitleLabel);
        view.addSubview(loginView);
        view.addSubview(loginButton);
        view.addSubview(errorLabel);

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: sag.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: sag.topAnchor, multiplier: 3),
            
            // Subtitle Label
            subtitleLabel.centerXAnchor.constraint(equalTo: sag.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            subtitleLabel.widthAnchor.constraint(lessThanOrEqualTo: sag.widthAnchor, multiplier: 1),
            
            // Login View
            loginView.centerYAnchor.constraint(equalTo: sag.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: sag.leadingAnchor, multiplier: 1),
            sag.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            // Login Button
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            // Error Label
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            errorLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),

        ])
    }
}


// MARK: - Actions
extension LoginViewController {
    @objc func singupTapped(){
        configureView(showMessage: false);
        guard let username = username, let password = password else {
            assertionFailure("username and password should never be nil");
            return;
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "username and password should never be blank")
            return;
        }
        
        if username == "owais" && password == "qwe" {
            loginButton.configuration?.showsActivityIndicator = true;
            delegate?.didLogin();
        } else {
            configureView(withMessage: "Incorrect credintionals")
        }
    }
    
    private func configureView(withMessage msg: String) {
        errorLabel.text = msg;
        errorLabel.isHidden = false;
    }
    private func configureView(showMessage isHidden: Bool) {
        errorLabel.isHidden = !isHidden;
    }
}
