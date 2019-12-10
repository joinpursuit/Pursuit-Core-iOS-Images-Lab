//
//  NetworkHelper.swift
//  NetworkHelper
//
//  Created by Alex Paul on 12/6/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//
import Foundation


// we need to make our NetworkHelper a singleton
// this means there will only ever be one instance of this class
// throughout the application, at no point will someone be able
// to create a new instance e.g NetworkHelper() will be a compiler error
class NetworkHelper {
  
  // we will create a shared instance of the NetworkHelper
  static let shared = NetworkHelper()
  
  private var session: URLSession
  
  // we will make the default initializer private
  // required in order to be considered a singleton
  // also forbids anyone from creating an instance of NetworkHelper
  private init() {
    session = URLSession(configuration: .default)
  }
  
  func performDataTask(with urlString: String,
                       completion: @escaping (Result<Data, AppError>) -> ()) {
    
    // creating a URL from the given String
    guard let url = URL(string: urlString) else {
      // handle bad url error case
      completion(.failure(.badURL(urlString)))
      return
    }
    
    // two states on dataTask, resume() and suspended by default
    // suspended simply won't perform network request
    // this ultimately leads to debugging errors and time lost if
    // you don't explicitly resume() request
    
    let dataTask = session.dataTask(with: url) { (data, response, error) in
      
      // 1. deal with error if any
      // check for client network errors
      if let error = error {
        completion(.failure(.networkClientError(error)))
      }
      
      // 2. downcast URLResponse (response) to HTTPURLResponse to
      //    get access to the statusCode property on HTTPURLResponse
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      
      // 3. unwrap the data object
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      // 4. validate that the status code is in the 200 range otherwise it's a
      //    bad status code
      switch urlResponse.statusCode {
      case 200...299: break // everything went well here
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
        return
      }
      
      // 5. capture data as success case
      completion(.success(data))
    }
    dataTask.resume()
    
  }
  
}
