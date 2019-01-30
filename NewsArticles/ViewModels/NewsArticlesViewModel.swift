//
//  NewsArticlesViewModel.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation


final class NewsArticlesViewModel: APIRouter {
    
    @discardableResult
    static func fetchNewsArticles(completion: @escaping NewsResponse) -> URLSessionTask? {
       return NewsRouter.getNewsItems(completion: completion)
    }
}
