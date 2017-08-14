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
        
        displayCount.text = model?.trueCount
        icon.sd_setImage(with: URL(string: model!.trueProductImageURL), placeholderImage: Placeholder.DefaultImage)
        selectedButton.isSelected = model!.isSelected
        displayProductName.text = model?.product_name
        displayMoney.text = model?.showPrice
        displayRemake.text = model?.product_attr
    }

}
extension ShoppingModel {
    
    var trueCount: String? {
        return goods_number.length == 0 ? nil : "x\(goods_number)"
    }
    
    var trueProductImageURL: String {
        return "\(host):\(picPort)/\(objectAddress)\(product_image_url)"
    }
    
    var showPrice: String? {
        return "¥\(sell_price)"
    }
    
}

