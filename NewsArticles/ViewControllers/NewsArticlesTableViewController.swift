//
//  NewsArticlesTableViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

//This class displays the list of news articles
final class NewsArticlesTableViewController: UITableViewController {
    
    struct Constants {
        static let cellIdentifier = "newsCell"
        static let pageSize = 15
        static let errorTitle = "Failed to get News List"
        static let errorMessage = "Oops! something went wrong when trying to get news list. Please check back again in a bit"
    }
    
    var uuidIndex = 0
    var newsItems: [News] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var uuids = [String]()
    var selectedNews: News = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News List"
        getNews()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110
    }
    
    ///Fetches the first batch of news list
    private func getNews() {
        NewsArticlesViewModel.fetchNewsArticles { (newsInfo, error) in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else { return }
                if error != nil {
                    self.showError(Constants.errorTitle, message: Constants.errorMessage)
                } else {
                    guard let news = newsInfo?.items?.result else { return }
                    self.newsItems = news
                    guard let uuidResult = newsInfo?.more?.result else { return }
                    self.uuids = uuidResult.compactMap { $0.uuid }
                }
            }
        }
    }
    
    ///Fetches more news when the user scrolls to the end of existing batch of news list
    private func getMoreNews() {
        var subArray = [String]()
        var toLimit = (Constants.pageSize + uuidIndex)
        if toLimit > uuids.count {
            toLimit = uuids.count - toLimit
        }
        for i in stride(from: uuidIndex, to: toLimit , by: 1) {
            subArray.append(uuids[i])
        }
        if subArray.isEmpty { return }
        NewsArticlesViewModel.fetchMoreNews(uuidList: subArray) { (newsInfo, error) in
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else { return }
                if error != nil {
                    self.showError(Constants.errorTitle, message: Constants.errorMessage)
                } else {
                    guard let news = newsInfo?.items?.result else { return }
                    self.newsItems.append(contentsOf: news)
                    self.uuidIndex += news.count - 1
                }
            }
        }
    }
    
    private func handleMoreNews() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? NewsDetailViewController else { return }
        vc.news = selectedNews
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

//MARK: UITableViewDelegate methods
extension NewsArticlesTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == newsItems.count { //we've reached to the end of the tableview
            if uuidIndex > 10 { uuidIndex += 15 }
            getMoreNews()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedNews = newsItems[indexPath.row]
        performSegue(withIdentifier: "newsListToDetail", sender: nil)
    }
    
}

