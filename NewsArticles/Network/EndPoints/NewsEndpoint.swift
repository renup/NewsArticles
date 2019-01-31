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
    
    struct Constants {
        static let sportsNews = "sports_news"
    }
    
    var path: String {
        switch self {
        case .newsSearch():
            return NetworkHelper.shared.baseURLString + Constants.sportsNews
        case .newsThumbnail(let imageString):
            return imageString
        }
    }
    
    var parameters: [URLQueryItem] {
        switch  self {
        case .newsSearch():
            let leaguesquery = URLQueryItem(name: "leagues", value: "sports")
            let streamTypeQuery = URLQueryItem(name: "stream_type", value: "headlines")
            let countQuery = URLQueryItem(name: "count", value: "10")
            let regionQuery = URLQueryItem(name: "region", value: "US")
            let langQuery = URLQueryItem(name: "lang", value: "en-US")
            return [leaguesquery, streamTypeQuery, countQuery, regionQuery, langQuery]
        case .newsThumbnail(_):
            return []
        }
        
    }    
    
}
