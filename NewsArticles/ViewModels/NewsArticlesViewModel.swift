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
        let task = NewsRouter.getNewsItems { (newsInfo, error) in
            if error != nil {
                completion(nil, error)
            } else {
                if let newsInfo = newsInfo {
                let sortedNews = sortNewsItemsBasedOnTheirPublishedDates(newsInfo)
                    completion(sortedNews, nil)
                    return
                }
                completion(newsInfo, nil)
            }
        }
        return task
    }
    
    static func fetchThumbnailImage(imageURLString: String, completion: @escaping ImageResponse) -> URLSessionTask? {
        return NewsRouter.getThumbnailImage(imageString: imageURLString, completion: completion)
    }
    
    @discardableResult
    static func fetchMoreNews(uuidList: [String], completion: @escaping NewsResponse) -> URLSessionTask? {
        return NewsRouter.getMoreNews(uuidList:uuidList, completion: completion)
    }
    
}

extension NewsArticlesViewModel {
    
    private static func sortNewsItemsBasedOnTheirPublishedDates(_ newsInfo: NewsInfo) -> NewsInfo {
        guard var newsItems = newsInfo.items, let result = newsItems.result  else { return newsInfo }
        var mutableNewsInfo = newsInfo
        let news = result.sorted { (news1, news2) -> Bool in
            guard let news1PublishValueStr = news1.published_at, let news1PublishValue = Int(news1PublishValueStr), let news2PublishValueStr = news2.published_at, let news2PublishValue = Int(news2PublishValueStr) else {
                return false
            }
            return news1PublishValue > news2PublishValue
        }
        newsItems.result = news
        mutableNewsInfo.items = newsItems
        return mutableNewsInfo
    }
}
