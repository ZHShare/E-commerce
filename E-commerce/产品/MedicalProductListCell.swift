//
//  MedicalProductListCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductListCell: UICollectionViewCell {
    @IBOutlet weak var contentBgView: UIView! { didSet { updateBg() } }

    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var displaySubTitle: UILabel!
    @IBOutlet weak var displayTitle: UILabel!
    
    fileprivate func updateBg() {
        
        contentBgView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        contentBgView.layer.borderWidth = 1
    }
}
