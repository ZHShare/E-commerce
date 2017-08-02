//
//  MineCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayTitle: UILabel!
   
    var model: MineModel? { didSet { updateUI() } }

    fileprivate func updateUI() {

        icon.image = UIImage(named: model!.imageString)
        displayTitle.text = model!.title
    }
}
