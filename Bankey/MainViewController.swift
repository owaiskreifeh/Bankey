//
//  MainViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews();
        setupTabBar();
    }
    
    private func setupViews(){
        let summaryVC   = SummaryViewController(),
            moneyVC     = MoneyViewController(),
            moreVC      = MoreViewController();
        
        summaryVC.setTabBar(imageName: "list.bullet.circle", title: "Summary");
        moneyVC.setTabBar(imageName: "dollarsign.circle", title: "Money");
        moreVC.setTabBar(imageName: "arrow.right.circle", title: "More");
        
        let summaryNC = UINavigationController(rootViewController: summaryVC),
            moneyNC = UINavigationController(rootViewController: moneyVC),
            moreNC = UINavigationController(rootViewController: moreVC);
        
        summaryNC.navigationBar.barTintColor = appColor;
        hideNavigationBarLine(summaryNC.navigationBar)
        
        let tabBarList = [ summaryNC, moneyNC, moreNC ];
        viewControllers = tabBarList;
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
    
}


class SummaryViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        style();
        layout();
    }
    
}

extension SummaryViewController {
    func style(){
        view.backgroundColor = .blue;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Summary";
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}


class MoneyViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        style();
        layout();
    }
    
}

extension MoneyViewController {
    func style(){
        view.backgroundColor = .systemRed;

        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Money";
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

class MoreViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        style();
        layout();
    }
    
}

extension MoreViewController {
    func style(){
        view.backgroundColor = .green;

        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "TEXT LABEL TODO";
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}


class ActionsViewController: UIViewController {
    
    let stackView = UIStackView();
    let label = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        style();
        layout();
    }
    
}

extension ActionsViewController {
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.spacing = 20;
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "TEXT LABEL TODO";
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label);
        view.addSubview(stackView);
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
