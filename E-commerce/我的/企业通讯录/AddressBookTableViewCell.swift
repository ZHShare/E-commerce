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
        icon.image = model?.image
    }
}
extension AddressBookModel {
    var image: UIImage? {
        return UIImage(named: head_portrait)
    }
}
