//
//  NewsRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

final class NewsRouter: APIRouter {
    
    @discardableResult
    static func getNewsItems(completion: @escaping NewsResponse) -> URLSessionTask? {
        return performRequest(route: NewsEndpoint.newsSearch(), completion: completion)
    }
    
}
