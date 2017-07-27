//
//  MedicalProductDetailsHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

public protocol MedicalProductDetailsHeaderDelegate {
    func priceClick()
    func share()
}

class MedicalProductDetailsHeader: UIView
{
    
    var delegate: MedicalProductDetailsHeaderDelegate?
    
    @IBOutlet weak var topView: UIView!

    @IBOutlet weak var displayTitle: UILabel!

    @IBOutlet weak var displayMoney: UIButton!
 
    @IBOutlet weak var displayStock: UILabel!
    
    @IBOutlet weak var displayPost: UILabel!
    
    @IBOutlet weak var displaySaled: UILabel!
    
    @IBOutlet weak var displayAddress: UILabel!
    
    @IBAction func login() {
    
        delegate?.priceClick()
    }
    
    @IBAction func share(_ sender: Any) {
        delegate?.share()
    }
    
}
