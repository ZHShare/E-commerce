//
//  MessageTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    var model: MessageModel? { didSet { updateUI() } }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var displaySubTitle: UILabel!
   
    fileprivate func updateUI() {
        
        iconImageView.image = UIImage(named: model!.imageString)
        displayTitle.text = model!.title
        displaySubTitle.text = model!.subTitle
    }

}
