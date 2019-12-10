//
//  AppError.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

// Error Handling against network requests
// some errors could be network connection lost
enum AppError: Error {
    case badURL(String) // associated value
    case noResponse
    case networkClientError(Error) // no internet connection
    case noData
    case decodingError(Error)
    case badStatusCode(Int) // 404, 500
    case badMimeType(String) // image/jpg
}
