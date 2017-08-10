//
//  ProductClassifyCollectionReusableView.swift
//  E-commerce
//
//  Created by YE on 2017/8/10.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductClassifyCollectionReusableView: UICollectionReusableView
{
    
    var model: SecondClassifyModel? {
        didSet { updateUI() }
    }
   
    @IBOutlet weak var displayHeaderTitle: UILabel!
   
    fileprivate func updateUI() {
        displayHeaderTitle.text = model?.cat_name
    }
    
}
