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
}
fileprivate extension PackModel {
    
    var imageString: String {
        return "\(host):\(8080)/\(objectAddress)\(product_image_url)"
    }
}
