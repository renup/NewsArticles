//
//  NewsArticlesTableViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    
    func configureCell(newsItem: News) {
        newsTitle.text = newsItem.title
        publisher.text = newsItem.publisher
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

