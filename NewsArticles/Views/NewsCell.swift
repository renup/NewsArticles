//
//  NewsCell.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/30/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsThumbnailImageView: UIImageView!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    var sessionTask: URLSessionTask?
    var cache = NSCache<NSString, UIImage>()
    
    func configureCell(newsItem: News) {
        newsTitle.text = newsItem.title
        publisher.text = newsItem.publisher
        newsThumbnailImageView.image = UIImage(named: "news")
        
        guard let imageResolutions = newsItem.main_image?.resolutions else { return }
        let urlString = imageResolutions.map{ $0 }.filter { $0.tag == "square-140x140" }
        guard let resolution = urlString.first, let urlStr = resolution.url  else { return }
        
        if let img = cache.object(forKey: urlStr as NSString) {
            newsThumbnailImageView.image = img
            return
        }
        
        sessionTask = NewsArticlesViewModel.fetchThumbnailImage(imageURLString: urlStr) {[weak self] (image, error) in
            
            guard let img = image else { return }
            DispatchQueue.main.async {
                self?.newsThumbnailImageView.image = img
                self?.cache.setObject(img, forKey: urlStr as NSString)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsThumbnailImageView.image = nil
        sessionTask?.cancel()
    }
    
}
