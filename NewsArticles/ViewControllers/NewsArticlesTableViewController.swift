//
//  NewsArticlesTableViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

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

class NewsArticlesTableViewController: UITableViewController {
    
    struct Constants {
        static let cellIdentifier = "newsCell"
    }
    
    var newsItems: [News] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NewsArticlesViewModel.fetchNewsArticles { (newsInfo, error) in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else { return }
                if error != nil {
                    print("Error - \(String(describing: error?.localizedDescription))")
                } else {
                    guard let news = newsInfo?.items?.result else { return }
                    self.newsItems = news
                }
            }
            
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
        
//        APIProcessor.getNewsArticlesList { (newsInfo, error) in
//            if error != nil {
//                print("Error - \(String(describing: error?.localizedDescription))")
//            } else {
//                print("newsInfo = \(String(describing: newsInfo?.items?.result?.first?.publisher))")
//            }
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! NewsCell
        cell.configureCell(newsItem: newsItems[indexPath.row])
        return cell
    }
    
    

}

