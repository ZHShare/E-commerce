//
//  ProductClassifyCollectionViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/10.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductClassifyCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var icon: UIImageView!
  
    @IBOutlet weak var displayTitle: UILabel!

    var model: SecondClassifySubModel? {
        didSet { updateUI() }
    }
    
    
    fileprivate func updateUI() {
        
        if model == nil { return }
        
        icon.sd_setImage(with: model!.imageURL, placeholderImage: Placeholder.DefaultImage)
        displayTitle.text = model?.sub_cat_name
    }
}
fileprivate extension SecondClassifySubModel {
    
    var imageURL: URL {
        let urlString = "\(host):\(8080)/\(objectAddress)\(cat_image_url)"
        return URL(string: urlString)!
    }
}
