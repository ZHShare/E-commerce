//
//  MedicalProductDetailsEvaluationCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

public protocol MedicalProductDetailsEvaluationCellDelegate {
    func didClickMore()
}

class MedicalProductDetailsEvaluationCell: UITableViewCell
{

    var model: MedicalProductDetailsModel.SectionTwo? { didSet { updateUI() }}
    
    fileprivate func updateUI() {
        
        displayUserName.text = model?.name
        displayContent.text = model?.content
        displayDate.text = model?.date
    }
    
    var delegate: MedicalProductDetailsEvaluationCellDelegate?
    
    @IBOutlet weak var userHeaderImageView: UIImageView!
   
    @IBOutlet weak var displayUserName: UILabel!

    @IBOutlet weak var displayContent: UILabel!
    
    @IBOutlet weak var displayDate: UILabel!
    
    @IBAction func more() {
        
        delegate?.didClickMore()
    }
}
