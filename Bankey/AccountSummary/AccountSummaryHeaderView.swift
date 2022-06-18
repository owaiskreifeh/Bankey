//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryHeaderView: UIView {
        
    @IBOutlet var contentView: AccountSummaryHeaderView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        commonInit();
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        commonInit();
    }
    
    func commonInit(){
        Bundle(for: AccountSummaryHeaderView.self)
            .loadNibNamed(String(describing: AccountSummaryHeaderView.self), owner: self);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }

}
	
extension AccountSummaryHeaderView {
    
    func style() {
        contentView.translatesAutoresizingMaskIntoConstraints = false;
        contentView.backgroundColor = appColor;
    }
    
    func layout() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
    }
    
}
