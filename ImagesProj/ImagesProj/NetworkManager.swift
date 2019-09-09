//
//  APIClient.swift
//  ImagesProj
//
//  Created by Kevin Natera on 9/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit


    
    class NetworkManager {
        private init() {}
        static let shared = NetworkManager()
        
        func fetchData(urlString: String,  completionHandler: @escaping (Result<Data,AppError>) -> ()) {
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(.badUrl))
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completionHandler(.failure(.networkError))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.noDataError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(.failure(.badHTTPResponse))
                    return
                }
                
                switch response.statusCode {
                case 404:
                    completionHandler(.failure(.notFound))
                case 401,403:
                    completionHandler(.failure(.unauthorized))
                case 200...299:
                    completionHandler(.success(data))
                default:
                    completionHandler(.failure(.other(errorDescription: "Wrong Status Code")))
                }
                }.resume()
        }
        
    }

