//
//  PokemonAPIClient.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct PokemonAPIClient {
    static func getPokemon(
}


//struct ComicAPIClient {
//static func getComic(for comicNum: Int, completion: @escaping (Result<Comic, NetworkError>) -> ()) {
//   // let endpointURLString = "https://xkcd.com/\(comicNum)/info.0.json"
//
//     let endpointURLString = comicNum > 0 ?
//        "https://xkcd.com/\(comicNum)/info.0.json" :
//        "https://xkcd.com/info.0.json"
//
//    NetworkHelper.shared.performDataTask(with: endpointURLString) {(result) in
//        switch result {
//        case .failure(let appError):
//            completion(.failure(.networkClientError(appError)))
//        case .success(let data):
//            // use to create our comic model
//            do {
//                let comic = try JSONDecoder().decode(Comic.self, from: data)
//                completion(.success(comic))
//            } catch {
//                completion(.failure(.decodingError(error)))
//                //                if let comic = Comic(from: data) {
//                //                completion(.success(comic))
//            }
//        }
//    }
//}
