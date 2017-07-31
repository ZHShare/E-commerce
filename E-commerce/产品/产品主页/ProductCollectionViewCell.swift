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
    
    var model: ButtonModel? { didSet { updateUI() } }
    
    var workModel: WorkModel? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        
        if let model = model {
            
            displayImageView.image = UIImage(named: model.imageString)
            displayTitle.text = model.title
        }
        
        else if let model = workModel {
            
            displayImageView.image = UIImage(named: model.imageString)
            displayTitle.text = model.title
        }
        
    }
    
}
