//
//  OrderListTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class OrderListTableViewCell: UITableViewCell
{

    var model: OrderListModel? { didSet { updateUI() } }
    
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
   
    @IBOutlet weak var displayProductName: UILabel!

    @IBOutlet weak var productRemake: UILabel!

    @IBOutlet weak var dispalyPrice: UILabel!
    @IBOutlet weak var displayCount: UILabel!
    @IBOutlet weak var displayStatus: UILabel!

    @IBAction func addEvaluation() {
    }
    @IBAction func del() {
    }

    fileprivate func updateUI() {
    
        displayTitle.text = model!.title
        productImageView.image = model?.image
        displayProductName.text = model?.productName
        productRemake.text = model?.remake
        dispalyPrice.text = model?.money
        displayCount.text = model?.count
        displayStatus.text = model?.status
    
    }
    
}
extension OrderListModel {
    
    var image: UIImage? {
        return UIImage(named: imageNamed)
    }
}
