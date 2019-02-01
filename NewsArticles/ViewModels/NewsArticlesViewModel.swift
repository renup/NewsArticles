//
//  NewsArticlesViewModel.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

///View model layer that communicates with view layer and the API layer
final class NewsArticlesViewModel: APIRouter {
    
    @discardableResult
    static func fetchNewsArticles(completion: @escaping NewsResponse) -> URLSessionTask? {
       return NewsRouter.getNewsItems(completion: completion)
    }
    
    static func fetchThumbnailImage(imageURLString: String, completion: @escaping ImageResponse) -> URLSessionTask? {
        return NewsRouter.getThumbnailImage(imageString: imageURLString, completion: completion)
    }
    
    @discardableResult
    static func fetchMoreNews(uuidList: [String], completion: @escaping NewsResponse) -> URLSessionTask? {
        return NewsRouter.getMoreNews(uuidList:uuidList, completion: completion)
    }
    
}
