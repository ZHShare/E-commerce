//
//  SureShoppingTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureShoppingProductTableViewCell: UITableViewCell
{

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayPrice: UILabel!
    @IBOutlet weak var displayCount: UILabel!
    @IBOutlet weak var displayRemake: UILabel!
    @IBOutlet weak var displayProductName: UILabel!
   
    var model: ShoppingModel? {
        didSet { updateUI() }
    }
    
    fileprivate func updateUI() {
        
        guard let model = model else { return }
        DispatchQueue.main.async {
            
            self.icon.sd_setImage(with: URL(string: model.trueProductImageURL)!, placeholderImage: Placeholder.DefaultImage)
            self.displayPrice.text = model.showPrice
            self.displayCount.text = model.trueCount
            self.displayRemake.text = model.product_attr
            self.displayProductName.text = model.product_name
        }
    }
}
