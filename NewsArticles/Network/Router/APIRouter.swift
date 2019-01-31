//
//  APIRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

protocol APIRouter {
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask?
    
    static func performRequestForImages(route: APIConfiguration, completion: @escaping ImageResponse) -> URLSessionTask?
}

extension APIRouter {
    
    private static func  getURL(route: APIConfiguration) -> URL? {
        let path = route.path
        
        guard var urlComponents = URLComponents(string: path) else { return nil }
        urlComponents.queryItems = route.parameters
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    static func performRequestForImages(route: APIConfiguration, completion: @escaping ImageResponse) -> URLSessionTask? {
       
        guard let url = getURL(route: route) else { return nil }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            } else if let dt = data, let img = UIImage(data: dt) {
                completion(img, nil)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    static func performRequest<T: Decodable>(route: APIConfiguration, completion: @escaping ((T?, Error?) -> Void)) -> URLSessionTask? {
        
        guard let url = getURL(route: route) else { return nil }

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
