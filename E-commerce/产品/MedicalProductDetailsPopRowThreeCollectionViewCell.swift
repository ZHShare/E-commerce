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

    var color: MedicalProductDetailsPopModel.Color? {
        didSet { updateUI() }
    }
    
    var ret: MedicalProductDetailsPopModel.Related? { didSet{ updateUI() } }
   
    @IBOutlet weak var displayUIContent: UIButton! {
        didSet {
            displayUIContent.titleLabel?.numberOfLines = 0
        }
    }

    @IBAction func didClick() {
        
        
    }
    
    fileprivate func updateUI() {
        
        if let color = color {
            displayUIContent.isSelected = color.isSelected
            displayUIContent.setTitle(color.title, for: .normal)
        }
        
        if let ret = ret {
            displayUIContent.isSelected = ret.isSelected
            displayUIContent.setTitle(ret.title, for: .normal)
        }
        
    }
}
