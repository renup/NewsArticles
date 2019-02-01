//
//  NewsDetailCell.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 1/31/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

enum CellType: Int {
    case title, content
}

final class NewsDetailCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
    }
    
    func configure(newsDetails: News, indexpath: IndexPath) {
        guard let celltype = CellType(rawValue: indexpath.row) else { return }
        
        switch celltype {
        case .title:
            if newsDetails.title?.count == 0  {
                self.textLabel?.text = "News Detail"
            }else {
                self.textLabel?.text = newsDetails.title
            }
        case .content:
            if newsDetails.content?.count == 0 {
                self.textLabel?.text = "Sorry this news does not have any content to display"
            } else {
                self.textLabel?.text = newsDetails.content?.htmlToString
            }
        }
    }
}


