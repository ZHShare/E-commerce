//
//  AddressBookTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressBookTableViewCell: UITableViewCell
{

    @IBOutlet var icon: UIImageView!
    @IBOutlet var displayName: UILabel!

    var model: AddressBookModel? {
        didSet { updateUI() }
    }
    
    fileprivate func updateUI() {
        
        displayName.text = model?.name
        icon.sd_setImage(with: URL(string: model!.head_portrait), placeholderImage: UIImage(named: "log_reg_icon"))
    }
}

