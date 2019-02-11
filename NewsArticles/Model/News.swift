//
//  News.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

struct NewsInfo: Decodable {
    var items: NewsItems?
    var more: More?
}

struct More: Decodable {
    var result: [UUIDList]?
}

struct UUIDList: Decodable {
    var uuid: String?
}

struct NewsItems: Decodable {
    var result: [News]?
}

struct News: Decodable {
    var title: String?
    var publisher: String?
    var main_image: MainImage?
    var content: String?
    var published_at: String?
}

struct MainImage: Decodable {
    var resolutions: [Resolutions]?
}

struct Resolutions: Decodable {
    var tag: String?
    var url: String?
}
