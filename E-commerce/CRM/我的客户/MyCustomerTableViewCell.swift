//
//  MyCustomerTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import SDWebImage
class MyCustomerTableViewCell: UITableViewCell
{

    var model: MyCustomerModel? {
        didSet { updateUI() }
    }

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayHospitalName: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayAddress: UILabel!
    @IBOutlet weak var displaySign: UILabel!
    
    
    fileprivate func updateUI() {
        
        if model == nil { return }
        
        icon.sd_setImage(with: model!.userIconURL, placeholderImage: Placeholder.DefaultImage!)
        displayHospitalName.text = model?.cust_name
        displayName.text = model?.hosp_principal
        displayAddress.text = model?.cust_address
        displaySign.text = model?.sign
        
    }
}
extension MyCustomerModel {
    
    var sign: String {
        
        var signString = ""
        switch cust_type {
        case "0": signString = "一般客户"
        case "1": signString = "重要客户"
        case "2": signString = "重点客户"
        case "3": signString = "非常重要客户"
        default:
            break
        }
        return signString
    }
    
    var userIconURL: URL {
        return URL(string: "\(host):\(picPort)/\(objectAddress)\(cust_avatar)")!
    }
}
