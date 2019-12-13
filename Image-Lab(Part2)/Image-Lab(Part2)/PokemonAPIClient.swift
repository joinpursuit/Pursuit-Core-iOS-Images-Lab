//
//  PokemonAPIClient.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct PokemonAPIClient {
    
    static func getPokemon(completion: @escaping (Result<[Cards], NetworkError>) -> ()) {
      let endpointURLString = "https://api.pokemontcg.io/v1/cards"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
                

            case .success(let data):
                
                do {
                    
                    let pokemon = try JSONDecoder().decode(PokemonData.self, from: data)
                    
                    completion(.success(pokemon.cards))
                    
                } catch {
                    
                    print(error)
                    completion(.failure(.decodingError(error)))
                    
                }
            }
        }
    }
}

