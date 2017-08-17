//
//  NoticeListTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/16.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class NoticeListTableViewCell: UITableViewCell
{

    var model: NoticeListModel? {
        didSet { updateUI() }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var displayDate: UILabel!

    
    fileprivate func updateUI() {
        
        if model == nil { return }
        DispatchQueue.main.async {
            
            self.icon.sd_setImage(with: self.model!.imageURL, placeholderImage: Placeholder.DefaultImage)
            self.displayTitle.text = self.model!.notice_title
            self.displayDate.text = self.model!.showDate
        }
    }
}
extension NoticeListModel {
    
    var imageURL: URL {
        let urlString = "\(host):\(picPort)/\(objectAddress)\(notice_img)"
        return URL(string: urlString)!
    }
    
    var showDate: String {
        return Date(fromString: add_time, format: "yyyyMMddHHmmss")!.toString(format: "yyyy-MM-dd")
    }
}
