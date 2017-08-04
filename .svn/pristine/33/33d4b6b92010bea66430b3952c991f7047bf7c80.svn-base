//
//  MyFavoriteTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MyFavoriteTableViewCell: UITableViewCell
{

    @IBOutlet var icon: UIImageView!
    @IBOutlet var displayProductName: UILabel!
    @IBOutlet var displayPrice: UILabel!

    var model: MyFavoriteModel? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        
        icon.image = model?.image
        displayProductName.text = model?.productName
        displayPrice.text = model?.price
    }
}

extension MyFavoriteModel {
    
    var image: UIImage? {
        return UIImage(named: imageNamed)
    }
}
