//
//  MedicalProductListCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import SDWebImage
class MedicalProductListCell: UICollectionViewCell {
    
    var model: ProductModel? { didSet { updateUI() } }
    
    
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
        
        if model == nil { return }
        
        displayImageView.image = Placeholder.DefaultImage
        displayImageView.image = model?.image
        displayTitle.text = model!.product_name
        displaySubTitle.text = model!.product_desc
        
        if model!.isDisCount {
            displayStatus.image = UIImage(named: "product_discount")
        }
        else if model!.isPromotion {
            displayStatus.image = UIImage(named: "product_promotion")
        }
        else {
            displayStatus.image = nil
        }
        
    }
}
extension ProductModel {
    
    var isDisCount: Bool {
        return is_promote == "1" ? true : false
    }
    
    var isPromotion: Bool {
        return is_hot == "1" ? true : false
    }
    
}
