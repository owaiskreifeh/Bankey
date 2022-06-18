//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let tableView = UITableView();
    
    var data: [SummaryCellView.ViewModel] = [];
    
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
        tableView.register(SummaryCellView.self, forCellReuseIdentifier: SummaryCellView.reuseId);
        tableView.rowHeight = SummaryCellView.rowHeight;
        tableView.tableFooterView = UIView(); // blank uiview
        
        setupHeaderView();
        
        fetchData();
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


// MARK: - UITableViewDataSource
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !data.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCellView.reuseId) as! SummaryCellView;
        cell.configure(with: data[indexPath.row]);
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
}


// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        data.append(SummaryCellView.ViewModel(accountType: .Banking, accountName: "Basic Savings"));
        data.append(SummaryCellView.ViewModel(accountType: .CreditCard, accountName: "Visa Islamic Bank"));
        data.append(SummaryCellView.ViewModel(accountType: .Investment, accountName: "General Saver"));
    }
}
