//
//  APIRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

protocol APIRouter {
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask?
}

extension APIRouter {
    
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask? {
        
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        urlComponents.queryItems = route.parameters
        
        guard let url = urlComponents.url else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let dt = data {
               print( String(describing: dt))
                do{
                    let result = try JSONDecoder().decode(T.self, from: dt)
                    completion(result, nil)
                } catch(let error) {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        })
        dataTask.resume()
        return dataTask
    }

}
