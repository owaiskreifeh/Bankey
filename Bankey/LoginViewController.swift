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
    
    var leadingEdgeOnScreen: CGFloat {
        sag.layoutFrame.origin.x + 8;
    }
    var leadingEdgeOffScreen: CGFloat {
        return view.frame.width * -1
    }
    
    var titleLeadingAnchor: NSLayoutConstraint?;
    var subtitleLeadingAnchor: NSLayoutConstraint?;

    weak var delegate: LoginViewControllerDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style();
        layout();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate();
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        animate()
    }

}

// MARK: Render
extension LoginViewController {
    
    func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Bankey";
        titleLabel.font = UIFont.systemFont(ofSize: 8 * 4);
        titleLabel.textAlignment = .center;
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        subtitleLabel.text = "Go do somethings with your bank here is a long text, really really long text you can't fit in 1 line";
        subtitleLabel.font = UIFont.systemFont(ofSize: 8 * 2);
        subtitleLabel.textColor = .systemGray;
        subtitleLabel.numberOfLines = 0;
        subtitleLabel.textAlignment = .center
        subtitleLabel.alpha = 0.0;

        
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.configuration = .filled();
        loginButton.configuration?.imagePadding = 8;
        loginButton.setTitle("Login", for: .normal);
        loginButton.addTarget(self, action: #selector(loginTapped), for: .primaryActionTriggered);
        
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
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: sag.topAnchor, multiplier: 3),
            // NOTE: titleLabel leadingAnchor is animated
            
            // Subtitle Label
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),

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
        
        // Animated Constraints
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen);
        titleLeadingAnchor?.isActive = true;
        
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen);
        subtitleLeadingAnchor?.isActive = true;
    }
}


// MARK: - Actions
extension LoginViewController {
    @objc func loginTapped(){
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
            loginButton.configuration?.showsActivityIndicator = false;
        } else {
            configureView(withMessage: "Incorrect credentials")
        }
    }
    
    private func configureView(withMessage msg: String) {
        errorLabel.text = msg;
        errorLabel.isHidden = false;
        shakeButton();
    }
    private func configureView(showMessage isHidden: Bool) {
        errorLabel.isHidden = !isHidden;
    }
}


// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 0.25 * 2, curve: .easeIn) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen;
            self.view.layoutIfNeeded();
        }
        
        animator1.startAnimation();
        
        let animator2 = UIViewPropertyAnimator(duration: 0.25 * 3, curve: .easeIn) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen;
            self.subtitleLabel.alpha = 1;
            self.view.layoutIfNeeded();
        }
        
        animator2.startAnimation();
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation();
        animation.keyPath = "position.x";
        animation.values = [0, 10, -10, 10, 0];
        animation.keyTimes = [0, 0.16, 0.5, 0.66, 1];
        animation.duration = 0.4;
        
        animation.isAdditive = true;
        loginButton.layer.add(animation, forKey: "shake")
    }
}
