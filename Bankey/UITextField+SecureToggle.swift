//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom);

extension UITextField {
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal);
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected);
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside);
        passwordToggleButton.tintColor = appColor;
        rightView = passwordToggleButton;
        rightViewMode = .always
        
    }
    @objc func togglePasswordView() {
        isSecureTextEntry.toggle();
        passwordToggleButton.isSelected.toggle();
    }
}
