//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryHeaderView: UIView {
        
    @IBOutlet var contentView: AccountSummaryHeaderView!
    
    // Config
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let shakeyBellView = ShakeyBellView();
    
    struct ViewModel {
        let welcomeMessage, name : String;
        let date: Date;
        
        var dateFormatted: String {
            return date.dayMonthYearString
        }
    }
    
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
        shakeyBellView.tapAction = shakeyBellViewTapped;
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    func configure(with viewModel: ViewModel){
        welcomeLabel.text = viewModel.welcomeMessage;
        nameLabel.text = viewModel.name;
        dateLabel.text = viewModel.dateFormatted;
    }

}
	
extension AccountSummaryHeaderView {
    
    func style() {
        contentView.translatesAutoresizingMaskIntoConstraints = false;
        contentView.backgroundColor = appColor;
    }
    
    func layout() {
        addSubview(contentView)
        contentView.addSubview(shakeyBellView);
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),

            // ShakeyBell View
            shakeyBellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shakeyBellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}


// MARK: - Actions
extension AccountSummaryHeaderView {
    func shakeyBellViewTapped() {
        print("Header shakeybell tapped")
    }
}
