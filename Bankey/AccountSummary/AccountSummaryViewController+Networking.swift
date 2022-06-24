//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by Owais Kreifeh on 19/06/2022.
//

import Foundation


enum NetworkError: Error {
    case serverError, decodeError;
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}

extension AccountSummaryViewController {
    
    func fetchProfile(for userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void){
        let baseURL = "https://fierce-retreat-36855.herokuapp.com/bankey"
        let profilePath = "\(baseURL)/profile/\(userId)?q=66";
        let url = URL(string: profilePath);
        
        guard let url = url else {
            print("Can not init URL")
            return
        }
        
        let session = URLSession(configuration: .default);
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // check for errors, and unwrap data
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                // json decode
                let decoder = JSONDecoder();
                
                do {
                    let profile = try decoder.decode(Profile.self, from: data);
                    completion(.success(profile))
                } catch{
                    completion(.failure(.decodeError))
                }
            }
            
        };
        task.resume();
    }
    
    func fetchData() {
        
        let group = DispatchGroup();
        let userId = String(Int.random(in: 1..<4))
        group.enter();
        fetchProfile(for: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave();
        }
        
        group.enter()
        fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave();
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData();
            self.tableView.refreshControl?.endRefreshing();
        }
    }
    
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts?q=55")!
        
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
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map { account in
            SummaryCellView.ViewModel(accountType: account.type,
                                         accountName: account.name,
                                         balance: account.amount)
        }
    }
    
    
}

