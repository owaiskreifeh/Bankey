//
//  ProfileManager.swift
//  Bankey
//
//  Created by Owais Kreifeh on 24/06/2022.
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

protocol ProfileManageable: AnyObject {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void);
}


class ProfileManager: ProfileManageable {
    
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void){
        let baseURL = "https://fierce-retreat-36855.herokuapp.com/bankey"
        let profilePath = "\(baseURL)/profile/\(userId)";
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
}
