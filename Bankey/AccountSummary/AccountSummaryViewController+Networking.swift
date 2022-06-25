//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Owais Kreifeh on 19/06/2022.
//

import Foundation
import UIKit

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton () -> Account {
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}

extension AccountSummaryViewController {
    
    
    func fetchData() {
        
        let group = DispatchGroup();
        let userId = String(Int.random(in: 1..<4))
        group.enter();
        profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.showErrorAlert(error);
                print(error.localizedDescription)
            }
            group.leave();
        }
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave();
        }
        
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing();
            guard let profile = self.profile else { return }
            self.isLoaded = true;

            self.configureTableHeaderView(with: profile)
            self.configureTableCells(with: self.accounts)

            self.tableView.reloadData();
        }
    }
    
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let rand = Int.random(in: 1...100)
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts?q=\(rand)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode([Account].self, from: data)
                    completion(.success(accounts))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }.resume()
    }
    
    func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        self.headerView.configure(with: vm)
        
    }
    
    func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map { account in
            SummaryCellView.ViewModel(accountType: account.type,
                                         accountName: account.name,
                                         balance: account.amount)
        }
    }

    func showErrorAlert(_ error: NetworkError) {
        let title: String;
        switch error {
        case .serverError:
            title = "Network error";
        case .decodeError:
            title = "Internal app error";
        }
        let alert = UIAlertController(title: title, message: error.localizedDescription , preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Close", style: .cancel));
        
        present(alert, animated: true)
    }
    
}

