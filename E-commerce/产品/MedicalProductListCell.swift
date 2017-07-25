//
//  MedicalProductListCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductListCell: UICollectionViewCell {
    
    var model: ListModel? { didSet { updateUI() } }
    
    
    @IBOutlet weak var contentBgView: UIView! { didSet { updateBg() } }

    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var displayStatus: UIImageView!
    
    @IBOutlet weak var displaySubTitle: UILabel!
    @IBOutlet weak var displayTitle: UILabel!
    
    fileprivate func updateBg() {
        
        contentBgView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        contentBgView.layer.borderWidth = 1
    }
    
    fileprivate func updateUI() {
        
        displayImageView.image = UIImage(named: model!.imageString)
        displayTitle.text = model!.title
        displaySubTitle.text = model!.title
        
        if model!.isDisCount {
            displayStatus.image = UIImage(named: "product_discount")
        }
        else if model!.isP {
            displayStatus.image = UIImage(named: "product_promotion")
        }
        else {
            displayStatus.image = nil
        }
    }
}
