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
            
            displayImageView.sd_setImage(with: URL(string: model.imageString), placeholderImage: Placeholder.DefaultImage)
            displayTitle.text = model.cat_name
        }
        
        else if let model = workModel {
            
            displayImageView.image = UIImage(named: model.imageString)
            displayTitle.text = model.title
        }
        
    }
    
}
fileprivate extension ButtonModel {
    
    var imageString: String {
        return "\(host):\(8080)/\(objectAddress)\(cat_image_url)"
    }
}
