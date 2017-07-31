//
//  MineHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

protocol MineHeaderViewDelegate {
    
    func headerClick(imageView: UIImageView)
    // 待提交
    func submit()
    
    // 待审核
    func check()
    // 待发货
    func sending()
    
    // 待收货
    func consignee()
    
    // 待评价
    func evaluation()
    
    // 退款
    func returnedMoney()
    
    // 更多订单
    func moreCoding()
    
}

class MineHeader: UIView
{
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var sendingButton: UIButton!
    @IBOutlet weak var consigneeButton: UIButton!
    @IBOutlet weak var evaluationButton: UIButton!
    @IBOutlet weak var returnedMoneyButton: UIButton!

    
    var delegate: MineHeaderViewDelegate?
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var displayUserName: UIButton!
    
    func demoClear() {
        
        if LoginStatus.isLogined == false {
            
            submitButton.alpha = 0
            checkButton.alpha = 0
            sendingButton.alpha = 0
            consigneeButton.alpha = 0
            evaluationButton.alpha = 0
            returnedMoneyButton.alpha = 0
        }
      
    }
    
    // 头像点击
    @IBAction func headerClick(_ sender: Any) {
        
        delegate?.headerClick(imageView: headerImageView)
    }
    
    // 待提交
    @IBAction func submit(_ sender: Any) {
        
        delegate?.submit()
    }
    
    // 待审核
    @IBAction func check(_ sender: Any) {
        
        delegate?.check()
    }
    // 待发货
    @IBAction func sending(_ sender: Any) {
        
        delegate?.sending()
    }
    
    // 待收货
    @IBAction func consignee(_ sender: Any) {
     
        delegate?.consignee()
    }
    
    // 待评价
    @IBAction func evaluation(_ sender: Any) {
        
        delegate?.evaluation()
    }
    
    // 退款
    @IBAction func returnedMoney(_ sender: Any) {
        
        delegate?.returnedMoney()
    }
    
    // 更多订单
    @IBAction func moreCoding(_ sender: Any) {
        
        delegate?.moreCoding()
    }

}
