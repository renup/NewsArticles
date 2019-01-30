//
//  APIConfiguration.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

protocol APIConfiguration {
    var path: String { get }
    var parameters: [URLQueryItem] { get }
//    func buildRequest(url: URL) -> URLSessionDataTask?
}
