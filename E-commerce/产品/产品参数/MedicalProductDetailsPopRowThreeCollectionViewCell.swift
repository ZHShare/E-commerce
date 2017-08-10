//
//  MedicalProductDetailsPopRowThreeCollectionViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/28.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductDetailsPopRowThreeCollectionViewCell: UICollectionViewCell
{
    
    static let nib: UINib = UINib(nibName: "MedicalProductDetailsPopRowThreeCollectionViewCell", bundle: nil)

    var model: MedicalProductDetailsModel.SubAttrVal? {
        didSet { updateUI() }
    }
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var displayUIContent: UIButton! {
        didSet {
            displayUIContent.titleLabel?.numberOfLines = 0
        }
    }

    fileprivate func updateUI() {
        
        DispatchQueue.main.async {
            
            self.displayUIContent.isSelected = self.model!.isSelected
            self.displayUIContent.setTitle(self.model?.attr_value, for: .normal)
        }
    }
    
}
