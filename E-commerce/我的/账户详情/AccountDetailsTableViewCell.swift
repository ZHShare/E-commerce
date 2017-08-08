//
//  AccountDetailsTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AccountDetailsTableViewCell: UITableViewCell
{

    @IBOutlet var icon: UIImageView!
    @IBOutlet var displayProductName: UILabel!
    @IBOutlet var displayRemake: UILabel!
    @IBOutlet var displayPrice: UILabel!
    @IBOutlet var displayCount: UILabel!
    @IBOutlet var displayDate: UILabel!
    @IBOutlet var displayCommission: UILabel!

    var model: AccountDetailsModel? {
        didSet {
        
            if Thread.isMainThread {
                 updateUI()
            }
            else {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
    
    fileprivate func updateUI() {
        
        if model == nil { return }
        icon.sd_setImage(with: URL(string: model!.trueImageUrl), placeholderImage: Placeholder.DefaultImage)
        displayProductName.text = model?.product_name
        displayRemake.text = model?.product_attr
        displayPrice.text = model?.showPrice
        displayCount.text = model?.showNumber
        displayDate.text = model?.trueDate
        displayCommission.text = model?.commissionPrice
    }
}
extension AccountDetailsModel {
    
    var trueImageUrl: String {
        return "\(host):\(8080)/\(objectAddress)\(product_image_url)"
    }
    
    var showPrice: String? {
        return "¥\(product_price)"
    }
    
    var showNumber: String {
        return "x\(product_num)"
    }
    
    var trueDate: String? {
        
        return Date(fromString: trans_time, format: "yyyyMMddHHmmss")?.toString(format: "yyyy-MM-dd")
    }
    
    var commissionPrice: String? {
        return "+\(commission_amount)"
    }
}
