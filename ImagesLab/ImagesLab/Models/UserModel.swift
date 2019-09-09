//
//  UserModel.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import UIKit



struct UserInfo: Codable {
    let results: [User]
    static func getUser(completionHandler: @escaping (Result<[User],AppError>) -> () ) {
        let url = "https://randomuser.me/api/?results=50"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedUser = try JSONDecoder().decode(UserInfo.self, from: data)
                    completionHandler(.success(decodedUser.results))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}

struct User: Codable{
    let gender: String
    let name: Name
    let location: Address
    let email: String
    let phone: String
    let picture: Picture
    let dob: DOB
    let cell: String

    
}
struct Name: Codable{
    let title: String
    let first: String
    let last: String
    
    func fullName() -> String {
        return "\(title.capitalizingFirstLetter()) \(first.capitalizingFirstLetter()) \(last.capitalizingFirstLetter())"
    }
}
struct Address: Codable{
    let street: String
    let city: String
    let state: String
    
    func fullAddress() -> String{
        return "\(street.capitalizingFirstLetter()), \(city.capitalizingFirstLetter()), \(state.capitalizingFirstLetter())"
    }
    
}
struct Picture: Codable{
    let large: String
    let thumbnail: String
    
//    func loadImage(imageView: UIImageView){
//        let urlStr = large
//        guard let url = URL(string: urlStr) else {fatalError()}
//        DispatchQueue.global(qos: .userInitiated).async {
//            do { let data = try Data(contentsOf: url)
//                imageView.image = UIImage(data: data)
//            }
//            catch {
//                fatalError("unable to pull image")
//            }
//        }
//    }
}

struct DOB: Codable {
    let date: String
    let age: Int
}


