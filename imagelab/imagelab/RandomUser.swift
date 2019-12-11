//
//  RandomUser.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct RandomUserWrapper: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable {
    let name: Name
    let location: Location
    let dob: DOB
    let phone: String
    let cell: String
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let city: String
    let state: String
}

struct DOB: Codable {
    let age: Int
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

extension RandomUser {
    private static func getUsers(from data: Data) throws -> [RandomUser] {
        let usersWrapper = try JSONDecoder().decode(RandomUserWrapper.self, from: data)
        return usersWrapper.results
    }
    
    static func loadUsers(completionHandler: @escaping (Result<[RandomUser],AppError>) -> ()) {
        let urlString = "https://randomuser.me/api/?results=20"
        
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let users = try RandomUser.getUsers(from: data)
                    completionHandler(.success(users))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
