//
//  UIImageView+Extensions.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()){
        //configure UIActivityIndicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .red
        activityIndicator.center = center //center of the UIImageView
        addSubview(activityIndicator)// adds the UIActivityIndicator View to the image view, dragging a view onto a view via code
        activityIndicator.startAnimating()
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
        
    }
}
