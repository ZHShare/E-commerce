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

    var model: AccountDetailsModel? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        
        icon.image = model?.image
        displayProductName.text = model?.productName
        displayRemake.text = model?.remake
        displayPrice.text = model?.money
        displayCount.text = model?.count
        displayDate.text = model?.date
        displayCommission.text = model?.commission
    }
}
extension AccountDetailsModel {
    
    var image: UIImage? {
        return UIImage(named: imageNamed)
    }
}
