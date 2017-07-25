//
//  MedicalProductViewFlowLayout.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    fileprivate func config() {
        
                estimatedItemSize = CGSize(width: (Screen.width - 6) / 2, height: 200)
    }
    
    
    
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let original = super.layoutAttributesForElements(in: rect)!
        
        for origin in original {
            
            let indexPath = origin.indexPath
            
            if origin.representedElementKind != nil {
                
                switch indexPath.section {
                case 0:
                    origin.frame = CGRect(origin: CGPoint.zero, size:  CGSize(width: Screen.width, height: 251))
                case 1:
                    origin.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Screen.width, height: 236))
                default:
                    break
                }
                
            }
        }
        
        return original
        
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        
        return true
    }
    
}
