//
//  MedicalProductDetailsHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc public protocol MedicalProductDetailsHeaderDelegate {
    func priceClick()
    func share()
}

class MedicalProductDetailsHeader: UIView
{
    
    weak var delegate: MedicalProductDetailsHeaderDelegate?
    var model: MedicalProductDetailsModel? {
        didSet { updateUI() }
    }
    
    @IBOutlet weak var topView: XHScrollView! {
        didSet { addScrollView() }
    }

//    fileprivate var tableHeader: XHScrollView!
    
    @IBOutlet weak var displayTitle: UILabel!

    @IBOutlet weak var displayMoney: UIButton!
 
    @IBOutlet weak var displayStock: UILabel!
    
    @IBOutlet weak var displayPost: UILabel!
    
    @IBOutlet weak var displaySaled: UILabel!
    
    @IBOutlet weak var displayAddress: UILabel!
    
    fileprivate func addScrollView() {
        
        topView.refreshFrame(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: Screen.width, height: topView.h)))
        topView.placeHoldImage = UIImage(named: "product_ad_default")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    @IBAction func login() {
    
        delegate?.priceClick()
    }
    
    @IBAction func share(_ sender: Any) {
        delegate?.share()
    }
    
    
    fileprivate func updateUI() {
        
        if let models = model?.scrolls {
        
            topView.pageControlShowStyle = .right
            topView.dataArray = models.map({ (model) -> String in
                return model.imageString
            })
        }
        
        DispatchQueue.main.async {
            
            self.displayTitle.text = self.model?.product_name
            self.displayMoney.setTitle(self.model?.showPrice, for: .normal)
            self.displayPost.text = self.model?.post
            self.displaySaled.text = self.model?.saled
            self.displayStock.text = self.model?.stock
            self.displayAddress.text = self.model?.address
        }
        
        
    }
    
}
extension MedicalProductDetailsModel {
    
    var showPrice: String {
        return LoginStatus.isLogined ? "¥\(market_price)(/\(weight))" : "***(请登录)"
    }
    
    var marketPrice: String {
        return LoginStatus.isLogined ? "¥\(market_price)" : "***"
    }
    
    var post: String {
        return "快递:\(shipping_price)"
    }
    
    var saled: String {
        return "已售:\(product_sold)"
    }
    
    var stock: String {
        return "库存:\(inventory_num)"
    }
    
    var address: String {
        return "发货:\(delivery_plac)"
    }
}

fileprivate extension MedicalProductDetailsModel.Scroll {
    
    var imageString: String {
        return "\(host):\(picPort)/\(objectAddress)\(pic_url)"
    }
}
