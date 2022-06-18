//
//  UIViewControllers+Utils.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit;

extension UIViewController {
    
    func setStatusBar(){
        let statusBarSize = view.window?.windowScene?.statusBarManager?.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize!)
        let statusBarView = UIView(frame: frame);
        
        statusBarView.backgroundColor = appColor;
        view.addSubview(statusBarView)
    }
    
    func setTabBar(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large);
        let image = UIImage(systemName: imageName, withConfiguration: configuration);
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0);
    }
    
}
