//
//  NewsRouter.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

typealias NewsResponse = (_ news: NewsInfo?, _ error: Error?) -> Void
typealias ImageResponse = (_ image: UIImage?, _ error: Error?) -> Void

final class NewsRouter: APIRouter {
    
    @discardableResult
    static func getNewsItems(completion: @escaping NewsResponse) -> URLSessionTask? {
        return performRequest(route: NewsEndpoint.newsSearch(), completion: completion)
    }
    
    static func getThumbnailImage(imageString: String, completion: @escaping ImageResponse) -> URLSessionTask? {
        return performRequestForImages(route: NewsEndpoint.newsThumbnail(imageString: imageString), completion: completion)
    }
    
    @discardableResult
    static func getMoreNews(uuidList: [String], completion: @escaping NewsResponse) -> URLSessionTask? {
       return performRequest(route: NewsEndpoint.moreNews(uuidList: uuidList), completion: completion)
    }
    
}
