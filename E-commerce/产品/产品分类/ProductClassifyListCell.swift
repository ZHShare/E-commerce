//
//  ProductClassifyTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/9.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductClassifyListCell: UITableViewCell
{

    @IBOutlet weak var displayTitle: UILabel!

    var model: FirstClassifyModel? {
        didSet { updateUI() }
    }
    
    fileprivate func updateUI() {
        displayTitle.text = model?.cat_name
    }
}
