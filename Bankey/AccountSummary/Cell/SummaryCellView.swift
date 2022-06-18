//
//  SummaryCell.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import Foundation
import UIKit;

class SummaryCellView: UITableViewCell {
    
    let typeLabel = UILabel();
    let underlineView = UIView();
    let nameLabel = UILabel();
    
    let balanceStackView = UIStackView();
    let balanceLabel = UILabel();
    let balanceAmountLabel = UILabel();
    
    let chevronImageView = UIImageView();
    
    static let reuseId = "SummaryCell";
    static let rowHeight = 100.0;
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup();
        layout();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


extension SummaryCellView {
    private func setup(){
        
        // Type label
        typeLabel.translatesAutoresizingMaskIntoConstraints = false;
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1);
        typeLabel.adjustsFontForContentSizeCategory = true;
        typeLabel.text = "Account Type";
        
        // Divider
        underlineView.translatesAutoresizingMaskIntoConstraints = false;
        underlineView.backgroundColor = appColor;
        
        // Name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body);
        nameLabel.adjustsFontForContentSizeCategory = true;
        nameLabel.text = "Title here Account name";
        
        // Balance stack view
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false;
        balanceStackView.axis = .vertical;
        
        // Balance label
        balanceLabel.text = "Balance Label";
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .caption1);
        balanceLabel.textAlignment = .right;
        
        // Balance amount label
        balanceAmountLabel.text = "00.00";
        balanceAmountLabel.font = UIFont.preferredFont(forTextStyle: .caption1);
        balanceAmountLabel.textAlignment = .right;

        
        // Chevron image
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false;
        chevronImageView.image = UIImage(systemName: "chevron.forward")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
    }
    
    private func layout(){
        
        contentView.addSubview(typeLabel);
        contentView.addSubview(underlineView);
        contentView.addSubview(nameLabel);
        
        contentView.addSubview(balanceStackView);
        balanceStackView.addArrangedSubview(balanceLabel);
        balanceStackView.addArrangedSubview(balanceAmountLabel);
        
        contentView.addSubview(chevronImageView);

        NSLayoutConstraint.activate([
            // Type label
            typeLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // Divider
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: 60.0),
            underlineView.heightAnchor.constraint(equalToConstant: 4.0),
            
            // Name label
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            
            // Balance stack view
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            // Chevron image
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: balanceLabel.topAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1),
        ])
    }
}
