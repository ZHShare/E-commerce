//
//  MedicalProductHeader.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductHeader: UICollectionReusableView {
    
    var models: [ADModel]? { didSet { updateUI() }  }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
   
    fileprivate lazy var tableHeader: XHScrollView = {
        
        let header = XHScrollView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 200))
        header.placeHoldImage = UIImage(named: "product_ad_default")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return header
    }()
    
    fileprivate func setupUI() {
        
        addSubview(tableHeader)
    }

    fileprivate func updateUI() {
        
        if let models = models {
            
            let ads = models.map({ (model) -> String in
                return model.imageString
            })
            
            tableHeader.dataArray = ads
        }
    }
}
fileprivate extension ADModel {
    
    var imageString: String {
        return "\(host):\(picPort)/\(objectAddress)\(image_url)"
    }
}
