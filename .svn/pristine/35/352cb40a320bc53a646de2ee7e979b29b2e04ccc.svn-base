//
//  MineDetailsDepartmentTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineDetailsDepartmentTableViewCell: UITableViewCell
{
    @IBOutlet weak var displayTitle: UILabel!
    var model: MineDetailsDepartmentModel? { didSet { updateUI() } }
    
    fileprivate func updateUI() {
        displayTitle.text = model?.title
    }

}
