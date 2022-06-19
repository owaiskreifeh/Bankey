//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let tableView = UITableView();
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped));
        barButtonItem.tintColor = .label;
        return barButtonItem;
    }();
    
    var data: [SummaryCellView.ViewModel] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
        
        setupNavigationBar();
    }
    
}

extension AccountSummaryViewController {
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
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
        view.backgroundColor = appColor;
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.backgroundColor = appColor;
        tableView.clipsToBounds = true;
        tableView.layer.cornerRadius = 8
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
        let savings = SummaryCellView.ViewModel(accountType: .Banking,
                                                            accountName: "Basic Savings",
                                                        balance: 929466.23)
        let chequing = SummaryCellView.ViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = SummaryCellView.ViewModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card",
                                                       balance: 412.83)
        let masterCard = SummaryCellView.ViewModel(accountType: .CreditCard,
                                                       accountName: "Student Mastercard",
                                                       balance: 50.83)
        let investment1 = SummaryCellView.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = SummaryCellView.ViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)

        data.append(savings)
        data.append(chequing)
        data.append(visa)
        data.append(masterCard)
        data.append(investment1)
        data.append(investment2)
    }
}


// MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped () {
        print("Logout tapped");
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
