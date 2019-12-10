//
//  UIImage+NetworkHandler.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

extension UIImage {
    static func getImage(urlString: String, completionHandler: @escaping (Result<UIImage, AppError>) -> ()){
        
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result {
            case.failure(let error):
                completionHandler(.failure(.networkClientError(error)))
            case .success(let data):
                guard let image = UIImage(data: data) else {fatalError("badData")}
                completionHandler(.success(image))
            }
        }
    }
}
