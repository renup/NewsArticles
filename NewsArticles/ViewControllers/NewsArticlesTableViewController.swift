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
    
    var uuids: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
    }
    
    private func getNews() {
        NewsArticlesViewModel.fetchNewsArticles { (newsInfo, error) in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else { return }
                if error != nil {
                    print("Error - \(String(describing: error?.localizedDescription))")
                } else {
                    guard let news = newsInfo?.items?.result else { return }
                    self.newsItems = news
                    guard let uuidResult = newsInfo?.more?.result else { return }
                    self.uuids = uuidResult.compactMap { $0.uuid }
                }
            }
        }
    }
    
    private func getMoreNews() {
        
    }
    
}

//MARK: UITableViewDataSource methods
extension NewsArticlesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! NewsCell
        cell.configureCell(newsItem: newsItems[indexPath.row])
        return cell
    }
}

