//
//  AppDelegate.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import UIKit;

let appColor: UIColor = .systemTeal;

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let loginViewController = LoginViewController();
    let onboardingContainerViewController = OnboardingContainerViewController();
    let logoutViewController = LogoutViewController();
    
    let mainViewController = MainViewController();
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible();
        window?.backgroundColor = .systemBackground;
        
        loginViewController.delegate = self;
        onboardingContainerViewController.delegate = self;
        logoutViewController.delegate = self;
        
//        let navController = UINavigationController(rootViewController: logoutViewController);
        window?.rootViewController = mainViewController;
        mainViewController.selectedIndex = 1
        return true;
    }
    
}


// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("from app delegate, did login");
        setRootViewController(
            LocalState.hasOnboarded
            ? logoutViewController
            : onboardingContainerViewController
        )
    }
}

// MARK: - LogoutViewControllerDelegate
extension AppDelegate: LogoutViewControllerDelegate {
    func didLogout() {
        print("from app delegate, did logout");
        setRootViewController(loginViewController)
    }
}

// MARK: - OnboardingContainerViewControllerDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("from app delegate, did finish onboarding");
        LocalState.hasOnboarded = true;
        setRootViewController(logoutViewController)
    }
}


// MARK: - Navigation
extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc;
            self.window?.makeKeyAndVisible();
            return;
        }
        
        window.rootViewController = vc;
        window.makeKeyAndVisible();
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromTop, animations: nil, completion: nil);
    }
}
