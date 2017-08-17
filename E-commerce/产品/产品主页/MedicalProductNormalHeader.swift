//
//  MedicalProductNormalHeader.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol MedicalProductNormalHeaderDelegate {
    
    func moreForTitle(title: String)
}

class MedicalProductNormalHeader: UICollectionReusableView
{

    @IBOutlet weak var displayTitle: UILabel!
    weak var delegate: MedicalProductNormalHeaderDelegate?
    
    @IBAction func more() {
        delegate?.moreForTitle(title: displayTitle.text!)
    }
    
}
