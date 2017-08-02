//
//  SureShoppingFooter.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureShoppingFooter: UIView
{

    var allCount: Int = 0 {
        
        didSet {
            displayAllCount.text = "共计\(allCount)件商品"
        }
        
    }
    
    var money: Int = 0 {
        
        didSet {
            displayAllMoney.text = "¥\(money).00"
        }
    }
    
    @IBOutlet var displayAllCount: UILabel!
    @IBOutlet var displayAllMoney: UILabel!
 
}
