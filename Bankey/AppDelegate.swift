//
//  AppDelegate.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import UIKit;

let appColor: UIColor = .systemBlue;

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
        
        // Quick test
//        setRootViewController(ShakeyBellViewAnimationRagViewController());
//        return true;
        
        loginViewController.delegate = self;
        onboardingContainerViewController.delegate = self;
        
        registerForNotifications();
        
        displayLogin();
        
        return true;
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController);
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboarded {
            prepMainView();
            setRootViewController(mainViewController);
        } else {
            setRootViewController(onboardingContainerViewController);
        }
    }
    
    private func prepMainView(){
        mainViewController.setStatusBar();
        UINavigationBar.appearance().isTranslucent = false;
        UINavigationBar.appearance().backgroundColor = appColor;
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
}


// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("from app delegate, did login");
        displayNextScreen();
    }
}


// MARK: - OnboardingContainerViewControllerDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("from app delegate, did finish onboarding");
        LocalState.hasOnboarded = true;
        displayNextScreen();
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


// MARK: - Notifications
extension AppDelegate {
    @objc func didLogout(){
        print("From app delegate got notification didLogout")
        displayLogin();
    }
}
