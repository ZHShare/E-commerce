//
//  MedicalProductDetailsModeCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductDetailsModeCell: UITableViewCell
{

    @IBOutlet weak var displayTitle: UILabel!
  
    var model: MedicalProductDetailsModel.SectionOne? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        
        displayTitle.text = model?.title
    }
    
}
