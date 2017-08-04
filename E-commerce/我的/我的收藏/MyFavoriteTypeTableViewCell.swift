//
//  MyFavoriteTypeTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MyFavoriteTypeTableViewCell: UITableViewCell
{

    @IBOutlet var displayTitle: UILabel!
    
    var model: MyFavoriteTypeModel? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        
        displayTitle.text = model?.title
    }
}
