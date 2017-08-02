//
//  ShoppingCarTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

protocol ShoppingCarTableViewCellDelegate {
    func didSelected(status: Bool, model: ShoppingModel)
}

class ShoppingCarTableViewCell: UITableViewCell
{

    var model: ShoppingModel? {
        didSet {
            updateUI()
        }
    }
    
    var delegate: ShoppingCarTableViewCellDelegate?
    
    @IBOutlet var selectedButton: UIButton!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var displayProductName: UILabel!
    @IBOutlet var displayRemake: UILabel!
    @IBOutlet var displayMoney: UILabel!
    @IBOutlet var displayCount: UILabel!
    
    @IBAction func selected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didSelected(status: sender.isSelected, model: model!)
    }
    
    fileprivate func updateUI() {
        
        selectedButton.isSelected = model!.isSelected
        icon.image = model!.image
        displayProductName.text = model!.productName
        displayRemake.text = model?.remake
        displayMoney.text = model?.money
        displayCount.text = model?.count
    }

}
extension ShoppingModel {
    
    var image: UIImage {
        return UIImage(named: imageNamed)!
    }
}
