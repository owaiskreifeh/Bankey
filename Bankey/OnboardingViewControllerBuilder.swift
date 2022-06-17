//
//  OnboardingViewControllerBuilder.swift
//  Bankey
//
//  Created by Owais Kreifeh on 17/06/2022.
//

import UIKit

class OnboardingViewControllerBuilder {
    
    var image: UIImage?;
    var labelText: String = "";
    
    func setImage(_ image: UIImage) -> OnboardingViewControllerBuilder {
        self.image = image;
        return self
    }
    
    func setLabel(_ labelText: String) -> OnboardingViewControllerBuilder {
        self.labelText = labelText;
        return self
    }
    
    func build() -> OnboardingViewController{
        let vc = OnboardingViewController();
        vc.imageView.image = image;
        vc.label.text = labelText;
        return vc;
    }
    
}
