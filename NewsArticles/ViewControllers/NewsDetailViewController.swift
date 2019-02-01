//
//  NewsDetailViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/31/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailViewController: UIViewController {    
    var news: News?
    
    @IBOutlet weak var newsDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Details"
        setUpViews()
    }
    
    private func setUpViews() {
        newsDetailTableView.rowHeight = UITableView.automaticDimension
        newsDetailTableView.estimatedRowHeight = 500
        newsDetailTableView.separatorStyle = .none
        newsDetailTableView.allowsSelection = false
    }
    
}

extension NewsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! NewsDetailCell
        guard let newsInfo = news else { return UITableViewCell()}
        cell.configure(newsDetails: newsInfo, indexpath: indexPath)
        return cell
    }
}
