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
        
        if model == nil { return }
        
        icon.sd_setImage(with: URL(string: model!.product_image_url), placeholderImage: Placeholder.DefaultImage)
        displayProductName.text = model?.product_name
        displayPrice.text = model?.showPrice
    }
}
extension MyFavoriteModel {
    
    var trueImageUrl: String {
        return "\(host):\(8080)/\(objectAddress)\(product_image_url)"
    }
    
    var showPrice: String? {
        return "¥\(sell_price)"
    }
}
