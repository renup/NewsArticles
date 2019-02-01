//
//  NewsDetailCell.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/31/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class NewsDetailCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
    }
    
    func configure(newsDetails: News, indexpath: IndexPath) {
        
        if indexpath.row == 0 { //label
            if newsDetails.title?.count == 0  {
                self.textLabel?.text = "News Detail"
            }else {
                self.textLabel?.text = newsDetails.title
            }
        } else {
            if newsDetails.content?.count == 0 {
                self.textLabel?.text = "Sorry this news does not have any content to display"
            } else {
                self.textLabel?.text = newsDetails.content
            }
        }
    }
}


