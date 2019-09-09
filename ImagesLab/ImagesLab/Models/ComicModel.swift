//
//  ComicModel.swift
//  ImagesLabTests
//
//  Created by Sam Roman on 9/5/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import UIKit

struct Comic: Codable {
    let num: Int
    let img: String


    static func getComic(comicNum: Int?, completionHandler: @escaping (Result<Comic, AppError>) -> ()){
        
        var url = "http://xkcd.com/info.0.json"
        
        if let comicNum = comicNum {
            url = "http://xkcd.com/\(comicNum)/info.0.json"
        }
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.badUrl))
            case .success(let data):
                do  {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comic))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }

}


//struct Comic: Codable {
//    let num: Int
//    let img: String
//
//
//
//
//    static func getInfo(from data: Data) -> Comic? {
//        do {
//            let comicInfo = try JSONDecoder().decode(Comic.self, from: data)
//            return comicInfo
//        } catch let decodeError {
//            fatalError("Could not decode \(decodeError)")
//        }
//
//    }
//
//}

//struct ComicAPIClient {
//    static let shared = ComicAPIClient()
//
//    enum FetchUserErrors: Error {
//        case remoteResponseError
//        case noDataError
//        case badDecodeError
//        case badURLError
//        case badHttpResponseCode
//    }
//
//    func fetchData(completionHandler: @escaping (Result<Comic, Error>) -> () ) {
//        let urlString = "https://xkcd.com/info.0.json"
//        guard let url = URL(string: urlString) else {fatalError()}
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard error == nil else {completionHandler(.failure(FetchUserErrors.remoteResponseError))
//                return
//            }
//
//            guard let data = data else {completionHandler(.failure(FetchUserErrors.noDataError))
//                return
//            }
//
//            guard let comicInfo = Comic.getInfo(from: data) else {completionHandler(.failure(FetchUserErrors.badDecodeError))
//                return
//            }
//
//            completionHandler(.success(comicInfo))}.resume()
//    }
//
//
//
//}
