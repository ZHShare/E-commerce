//
//  ProductCollectionViewCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var displayTitle: UILabel!
    
    var model: ButtonModel? {
        didSet {
            
            guard let model = model else {
                return
            }
            
            displayImageView.image = UIImage(named: model.imageString)
            displayTitle.text = model.title
        }
    }
}
