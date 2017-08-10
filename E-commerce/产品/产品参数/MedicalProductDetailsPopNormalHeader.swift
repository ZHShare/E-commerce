//
//  MedicalProductDetailsPopNormalHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/28.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit



class MedicalProductDetailsPopNormalHeader: UICollectionReusableView
{

    @IBOutlet weak var displaySubTitle: UILabel!
    @IBOutlet weak var displayTitle: UILabel!
    static let nib = UINib(nibName: "MedicalProductDetailsPopNormalHeader", bundle: nil)

    var model: MedicalProductDetailsModel.Attr? {
        didSet { updateUI() }
    }
    
    fileprivate func updateUI() {
        DispatchQueue.main.async {
            
            self.displayTitle.text = self.model?.attr_name
            self.displaySubTitle.text = self.model?.attr_desc
        }
    }
}
