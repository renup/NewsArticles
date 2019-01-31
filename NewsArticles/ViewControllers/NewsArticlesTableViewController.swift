//
//  NewsArticlesTableViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

class NewsArticlesTableViewController: UITableViewController {
    
    struct Constants {
        static let cellIdentifier = "newsCell"
    }
    
    var newsItems: [News] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var uuids: [UUIDList] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        NewsArticlesViewModel.fetchNewsArticles { (newsInfo, error) in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else { return }
                if error != nil {
                    print("Error - \(String(describing: error?.localizedDescription))")
                } else {
                    guard let news = newsInfo?.items?.result else { return }
                    self.newsItems = news
                    guard let uuids = newsInfo?.more?.result else { return }
                    self.uuids = uuids
                }
            }
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
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

