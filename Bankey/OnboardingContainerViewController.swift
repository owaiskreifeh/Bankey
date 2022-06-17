//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding();
}

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController;
    
    let skipButton: UIButton = UIButton(type: .system);
    
    weak var delegate: OnboardingContainerViewControllerDelegate?;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewControllerBuilder()
            .setImage(UIImage(named: "world")!)
            .setLabel("rem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It w")
            .build();
        
        let page2 = OnboardingViewControllerBuilder()
            .setImage(UIImage(named: "thumbs")!)
            .setLabel("b page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various v")
            .build();
        
        let page3 = OnboardingViewControllerBuilder()
            .setImage(UIImage(named: "delorean")!)
            .setLabel("The standard chunk of Lorem Ipsum used since the 1500s is reproduced")
            .build();
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup();
        style();
        layout();

        
        
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

extension OnboardingContainerViewController {
    private func setup(){
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
        
        currentVC = pages.first!
        
        skipButton.addTarget(self, action: #selector(skipTapped), for: .primaryActionTriggered)
    }
    
    private func style(){
        
        // Skip Button
        skipButton.translatesAutoresizingMaskIntoConstraints = false;
        skipButton.setTitle("Skip", for: [])
    }
    
    private func layout(){
        view.addSubview(pageViewController.view)
        view.addSubview(skipButton);

        NSLayoutConstraint.activate([
            // Page View
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
            
            // Skip button
            skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
        ])
    }
}

// MARK: - Actions

extension OnboardingContainerViewController {
    @objc func skipTapped(_ sender: UIButton){
        print("Skip");
        delegate?.didFinishOnboarding()
    }
}

// MARK: - ViewControllers
class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed;
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
