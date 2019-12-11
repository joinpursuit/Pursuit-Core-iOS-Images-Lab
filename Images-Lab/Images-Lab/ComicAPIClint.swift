//
//  ComicAPIClint.swift
//  Images-Lab
//
//  Created by Yuliia Engman on 12/10/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    static func getComic(with urlString: String, completion: @escaping (Result<Comic, NetworkError>) -> ()) {
        //let endpointURLString = "http://xkcd.com/614/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: urlString) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                // use to create our comic model
                do {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    completion(.success(comic))
                } catch {
                    completion(.failure(.decodingError(error)))
                    //                if let comic = Comic(from: data) {
                    //                completion(.success(comic))
                }
            }
        }
    }
    
    static func getMostRecentComic(completion: @escaping (Result<Comic, NetworkError>) -> ()) {
        let endpointURLString = "http://xkcd.com/614/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                // use to create our comic model
                do {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    completion(.success(comic))
                } catch {
                  completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
