//
//  ProductFlowLayout.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        scrollDirection = UICollectionViewScrollDirection.horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollDirection = UICollectionViewScrollDirection.horizontal
    }
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let original = super.layoutAttributesForElements(in: rect)!
        
        for origin in original {
            
            if origin.representedElementKind != nil {
                
                var frame = origin.frame
                frame.origin.x = 0
                origin.frame = frame
            }
        }

        return original
    }
    
    
}
