//
//  APIRest.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import Foundation

/// Common proccess to perfomr a request. Create a dataTask and execute it
/// - Parameters:
///   - url: valid url to be requested
///   - session: optional session that will be manage the request
///   - completion: block where if be returned the raw Data
func performRequest(_ url: String, session: URLSession = URLSession.shared, completion: @escaping RequestResponse) {
    guard let URL = URL(string: url) else {
        completion(nil)
        return
    }
    
    let request = URLRequest(url: URL)
    let task = session.dataTask(with: request) { data, response, error in
        if error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode < 400, let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
    
    task.resume()
}
