//
//  AppError.swift
//  ImagesProj
//
//  Created by Kevin Natera on 9/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit

enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case badHTTPResponse
    case badUrl
    case notFound 
    case unauthorized
    case badImageData
    case other(errorDescription: String)
}
