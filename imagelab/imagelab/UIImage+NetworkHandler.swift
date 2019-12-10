//
//  UIImage+NetworkHandler.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageMade(urlString: String) -> UIImage {
        guard let url = URL(string: urlString) else { fatalError("badURL")}
        var image: UIImage?
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case.failure(let error):
                print(error)
            case .success(let data):
                image = UIImage(data: data)
            }
        }
        return image!
    }
}
