//
//  APIProcessor.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

final class APIProcessor {
    struct Constants {
        static let baseURLString = "http://doubleplay-sports-yql.media.yahoo.com/v3/sports_news?leagues=sports&stream_type=headlines&count=10&region=US&lang=en-US"
        static let sportsNews = "sports_news"
    }
    
    static func getNewsArticlesList(completion: @escaping NewsResponse) {
        guard var urlComponents = URLComponents(string: Constants.baseURLString) else { return }
        let leaguesquery = URLQueryItem(name: "leagues", value: "sports")
        let streamTypeQuery = URLQueryItem(name: "stream_type", value: "headlines")
        let countQuery = URLQueryItem(name: "count", value: "10")
        let regionQuery = URLQueryItem(name: "region", value: "US")
        let langQuery = URLQueryItem(name: "lang", value: "en-US")
        urlComponents.queryItems = [leaguesquery, streamTypeQuery, countQuery, regionQuery, langQuery]
        
        guard let url = urlComponents.url else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            } else if let dt = data {
                let newsInfo = try! JSONDecoder().decode(NewsInfo.self, from: dt)
                completion(newsInfo, nil)
            }
        }
        dataTask.resume()
        
    }
}
