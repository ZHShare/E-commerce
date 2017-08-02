//
//  MineDetailsNormalTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineDetailsNormalTableViewCell: UITableViewCell
{

    @IBOutlet weak var displaySubTitle: UILabel!
    @IBOutlet weak var displayTitle: UILabel!
  
    var title: MineDetailsTitleModel? {
        didSet { udpateTitle() }
    }

    fileprivate func udpateTitle() {
        
        displayTitle.text = title!.title
    }
}
