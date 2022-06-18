//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let tableView = UITableView();
    
    let data = [
        "Pacman",
        "Space invader",
        "Space patrol",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
    }
    
}

extension AccountSummaryViewController {
    
    func setup(){
        tableView.delegate = self;
        tableView.dataSource = self;
        
        setupHeaderView()
    }
    
    func setupHeaderView(){
        let header = AccountSummaryHeaderView(frame: .zero);
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize);
        header.frame.size = size;
        
        tableView.tableHeaderView = header;
    }
    
    func style(){
        
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout(){
        view.addSubview(tableView);
        NSLayoutConstraint.activate([
            
            // Table View
            tableView.topAnchor.constraint(equalTo: sag.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: sag.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: sag.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: sag.leadingAnchor),
            
        ])
    }
}


// MARK: - UITableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false;
    }
}


// MARK: -
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = data[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
}
