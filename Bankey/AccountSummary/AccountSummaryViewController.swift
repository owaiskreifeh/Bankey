//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // request model
    var profile: Profile?;
    var accounts: [Account] = [];
    
    // view model
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date());
    var accountCellViewModels: [SummaryCellView.ViewModel] = [];
    
    // Components
    let tableView = UITableView();
    var headerView = AccountSummaryHeaderView(frame: .zero);
    let refreshControl = UIRefreshControl();
    
    var isLoaded = false;
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped));
        barButtonItem.tintColor = .label;
        return barButtonItem;
    }();
        
    override func viewDidLoad() {
        super.viewDidLoad();
        setup();
        style();
        layout();
        
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
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseId);

        tableView.rowHeight = SummaryCellView.rowHeight;
        tableView.tableFooterView = UIView(); // blank uiview
        
        setupNavigationBar();
        setupHeaderView();
        setupRefreshControl();
        setupSkeletons();
        fetchData()

    }
    
    func setupSkeletons() {
        let row = Account.makeSkeleton();
        accounts = Array(repeating: row, count: 10);
        configureTableCells(with: accounts);
    }
    
    func setupRefreshControl() {
        refreshControl.tintColor = appColor;
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged);
        tableView.refreshControl = refreshControl;
    }
    
    func setupHeaderView(){
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize);
        headerView.frame.size = size;
        
        tableView.tableHeaderView = headerView;
    }
    
    func style(){
        view.backgroundColor = appColor;
        // Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.backgroundColor = appColor;
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
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        if (isLoaded){
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCellView.reuseId) as! SummaryCellView;
            cell.configure(with: accountCellViewModels[indexPath.row]);
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseId) as! SkeletonCell;
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count;
    }
}

// MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped () {
        print("Logout tapped");
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent () {
        reset();
        setupSkeletons();
        tableView.reloadData();
        fetchData();
    }
    
    private func reset(){
        profile = nil;
        accounts = [];
        isLoaded = false;
    }
}
