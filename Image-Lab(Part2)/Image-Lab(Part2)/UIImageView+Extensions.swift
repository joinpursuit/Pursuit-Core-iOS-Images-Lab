//
//  UIImageView+Extensions.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/12/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        NetworkHelper.shared.performDataTask(with: urlString) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                if let pokemonImage = UIImage(data: data) {
                    completion(.success(pokemonImage))
                }
            }
        }
    }
}
