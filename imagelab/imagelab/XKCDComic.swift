//
//  XKCDComic.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct XKCDComic: Codable {
    let img: String
    let num: Int
    
    static func getXKCDComic() -> XKCDComic {
        var xkcdComic: XKCDComic?
        let urlString = "https://xkcd.com/info.0.json"
        guard let url = URL(string: urlString) else {
            fatalError("badURL")
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    xkcdComic = try JSONDecoder().decode(XKCDComic.self, from: data)
                }
                catch {
                    fatalError("Error decoding: \(error)")
                }
            }
        }
        return xkcdComic!
    }
}
