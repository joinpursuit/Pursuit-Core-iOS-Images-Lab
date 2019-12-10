//
//  PokemonCard.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct PokemonCardWrapper: Codable {
    let cards: [PokemonCard]
}

struct PokemonCard: Codable {
    let name: String
    let imageUrlHiRes: String
    let types: [String]?
    let weaknesses: [Weakness]?
    let set: String
}

struct Weakness: Codable {
    let type: String
}

extension PokemonCard {
    private static func getCards(from data: Data) throws -> [PokemonCard] {
        let cards = try JSONDecoder().decode(PokemonCardWrapper.self, from: data)
        return cards.cards
    }
    
    static func loadCards(completionHandler: @escaping (Result<[PokemonCard], AppError>) -> ()) {
        let urlString = "https://api.pokemontcg.io/v1/cards"
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let cards = try PokemonCard.getCards(from: data)
                    completionHandler(.success(cards))
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }
    }
}
