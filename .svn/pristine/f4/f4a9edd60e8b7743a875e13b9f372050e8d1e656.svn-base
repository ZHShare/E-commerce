//
//  ProductEvaluationTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductEvaluationTableViewCell: UITableViewCell
{

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var displayContent: UILabel!
    @IBOutlet weak var displayDate: UILabel!

    var model: ProductEvalutaionModel? { didSet{ updateUI() } }
    
    fileprivate func updateUI() {
        
        displayName.text = model?.name
        displayContent.text = model?.content
        displayDate.text = model?.date
    }
    
}

