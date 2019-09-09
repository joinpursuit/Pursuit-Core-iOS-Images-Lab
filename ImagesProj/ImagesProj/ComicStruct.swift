//
//  ComicStruct.swift
//  ImagesProj
//
//  Created by Kevin Natera on 9/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit

struct Comic: Codable {
    let num: Int
    let img: String
    
    
    static func getComic(userNum: Int?,completionHandler: @escaping (Result<Comic,AppError>) -> () ) {
        
        var url = "https://xkcd.com/info.0.json"
        if let number = userNum{
            url = "https://xkcd.com/\(number)/info.0.json"
        }
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let comicFromJSON = try JSONDecoder().decode(Comic.self, from: data)
                    completionHandler(.success(comicFromJSON))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
