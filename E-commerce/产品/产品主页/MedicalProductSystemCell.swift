//
//  MedicalProductSystemCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductSystemCell: UICollectionViewCell {

    var model: PackModel? { didSet { updateUI() }  }
    var productModel: ProductModel? { didSet { updateProductUI() } }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displaySystemName: UILabel!
    @IBOutlet weak var displaySystemSub: UILabel!
    
    fileprivate func updateUI() {
        
        guard let model = model else {
            return
        }
        
        DispatchQueue.main.async {
            
            self.icon.sd_setImage(with: URL(string: model.imageString), placeholderImage: Placeholder.DefaultImage)
            self.displaySystemName.text = model.product_name
            self.displaySystemSub.text = model.product_desc
        }
        
    }
    
    fileprivate func updateProductUI() {
        
        if productModel == nil { return }
        DispatchQueue.main.async {
            
            self.icon.sd_setImage(with: self.productModel!.imageURL, placeholderImage: Placeholder.DefaultImage)
            self.displaySystemSub.text = self.productModel?.product_desc
            self.displaySystemName.text = self.productModel?.product_name
        }
    }
}
fileprivate extension ProductModel {
    
    var imageURL: URL {
        let urlString = "\(host):\(picPort)/\(objectAddress)\(product_image_url)"
        return URL(string: urlString)!
    }
}

fileprivate extension PackModel {
    
    var imageString: String {
        return "\(host):\(picPort)/\(objectAddress)\(product_image_url)"
    }
}
