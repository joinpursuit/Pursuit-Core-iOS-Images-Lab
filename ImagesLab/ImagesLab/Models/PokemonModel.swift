//
//  PokemonModel.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import UIKit

struct Cards: Codable {
    let cards: [Pokemon]
    static func loadPoke(completionHandler: @escaping (Result<[Pokemon],AppError>) -> () ) {
        
        let url = "https://api.pokemontcg.io/v1/cards"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Cards.self, from: data)
                    completionHandler(.success(pokemon.cards))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
struct Pokemon: Codable{
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let types: [String]?
    let set: String?
    let weaknesses: [Weakness]?
    
//    mutating func allTypes() -> String {
//        var typeStr = ""
//        if let types = types {
//
//    }
    
    
}




struct Weakness: Codable {
    let type: String
    let value: String
}
