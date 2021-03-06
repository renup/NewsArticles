//
//  NewsEndpoint.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/29/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

enum NewsEndpoint: APIConfiguration {
    
    case newsSearch()
    case newsThumbnail(imageString: String)
    case moreNews(uuidList: [String])
    
    struct Constants {
        static let baseURLString = "http://doubleplay-sports-yql.media.yahoo.com/v3/"
        static let sportsNews = "sports_news"
        static let newsItems = "news_items"
    }
    
    var path: String {
        switch self {
        case .newsSearch():
            return Constants.baseURLString + Constants.sportsNews
        case .newsThumbnail(let imageString):
            return imageString
        case .moreNews(_):
            return Constants.baseURLString + Constants.newsItems
        }
    }
    
    var parameters: [URLQueryItem] {
        switch  self {
        case .newsSearch():
            let leaguesquery = URLQueryItem(name: "leagues", value: "sports")
            let streamTypeQuery = URLQueryItem(name: "stream_type", value: "headlines")
            let countQuery = URLQueryItem(name: "count", value: "15")
            let regionQuery = URLQueryItem(name: "region", value: "US")
            let langQuery = URLQueryItem(name: "lang", value: "en-US")
            return [leaguesquery, streamTypeQuery, countQuery, regionQuery, langQuery]
        case .newsThumbnail(_):
            return []
        case .moreNews(let uuidList):
            var uuidString = uuidList.map{ $0 + "," }.reduce("", +)
            uuidString.removeLast()
            
            let uuidQuery = URLQueryItem(name: "uuids", value: uuidString)
            return [uuidQuery]
        }
        
    }    
    
}
