//
//  MedicalProductHeader.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductHeader: UICollectionReusableView {
    
    
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

}
