//
//  MedicalProductDetailsFooter.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol MedicalProductDetailsFooterDelegate {
    
    func customerService()
    func addShoppingCar()
    func ordding()
}

class MedicalProductDetailsFooter: UIView
{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        frame = CGRect(x: 0, y: Screen.height - 40, width: Screen.width, height: 40)
        backgroundColor = .white
        
        let width = Screen.width / 3.0
        
        let customerServiceButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        customerServiceButton.addTarget(self, action: #selector(customerService), for: UIControlEvents.touchUpInside)
        customerServiceButton.setTitle("客服", for: UIControlState.normal)
        customerServiceButton.setTitleColor(UIColor.black, for: .normal)
        customerServiceButton.setImage(UIImage(named: "product_details_kf"), for: .normal)
        addSubview(customerServiceButton)
        
        let addShoppingButton = UIButton(frame: CGRect(x: width, y: 0, width: width, height: 40))
        addShoppingButton.addTarget(self, action: #selector(addShoppingCar), for: UIControlEvents.touchUpInside)
        addShoppingButton.setTitle("加入购物车", for: UIControlState.normal)
        addShoppingButton.setTitleColor(UIColor.white, for: .normal)
        addShoppingButton.setBackgroundImage(UIImage(named: "product_details_images"), for: .normal)
        addSubview(addShoppingButton)
        
        let orddingButton = UIButton(frame: CGRect(x: width*2, y: 0, width: width, height: 40))
        orddingButton.addTarget(self, action: #selector(ordding), for: UIControlEvents.touchUpInside)
        orddingButton.setTitle("马上订购", for: UIControlState.normal)
        orddingButton.setTitleColor(UIColor.white, for: .normal)
        orddingButton.setBackgroundImage(UIImage(named: "product_details_ordding"), for: .normal)
        addSubview(orddingButton)
        
    }
    
    weak var delegate: MedicalProductDetailsFooterDelegate?
    
    @objc fileprivate func customerService() {
        delegate?.customerService()
    }

    @objc fileprivate func addShoppingCar() {
        delegate?.addShoppingCar()
    }
    
    @objc fileprivate func ordding() {
        delegate?.ordding()
    }
}
