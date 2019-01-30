//
//  NewsArticlesTableViewController.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/28/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

class NewsArticlesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NewsArticlesViewModel.fetchNewsArticles { (newsInfo, error) in
            if error != nil {
                print("Error - \(String(describing: error?.localizedDescription))")
            }
                print("newsInfo = \(String(describing: newsInfo?.items?.result?.first?.publisher))")
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
       return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

