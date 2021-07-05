//
//  ImagesAPIClient.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct ComicAPI{
    static func getComics(endPointURLString: String, completion: @escaping (Result<Comic,AppError>)->()){
        //var comics = Comic(month: "", num: 1, year: "", title: "", transcript: "", img: "", day: "")
        NetworkHelper.shared.performDataTask(with: endPointURLString) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let comics = try JSONDecoder().decode(Comic.self, from: data)
                    completion(.success(comics))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        //return comics
    }
}
struct PokemonAPI {
    static func getCards(endPointURLString: String, completion: @escaping (Result<[Pokemon],AppError>)->()){
        NetworkHelper.shared.performDataTask(with: endPointURLString) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                    let pokemon = pokemonData.cards
                    completion(.success(pokemon))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

struct UsersAPI {
    static func getUsers(endPointURLString:String, completion: @escaping (Result<[User], AppError>) -> ()){
        NetworkHelper.shared.performDataTask(with: endPointURLString) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let data):
                do{
                    let usersData = try JSONDecoder().decode(UserData.self, from: data)
                    let user = usersData.results
                    completion(.success(user))
                } catch{
                completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
