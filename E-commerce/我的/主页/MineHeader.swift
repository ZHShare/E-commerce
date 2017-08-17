//
//  MineHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol MineHeaderViewDelegate {
    
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
    
    fileprivate var submitCount: String? {
        get { return submitButton.currentTitle }
        set {
            
            if newValue == "0" || newValue == nil {
                submitButton.alpha = 0
            }
            else {
                submitButton.alpha = 1
                submitButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
    fileprivate var checkCount: String? {
        get { return checkButton.currentTitle }
        set {
            
            if newValue == "0" || newValue == nil {
                checkButton.alpha = 0
            }
            else {
                checkButton.alpha = 1
                checkButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
    fileprivate var sendCount: String? {
        get { return sendingButton.currentTitle }
        set {
            
            if newValue == "0" || newValue == nil {
                sendingButton.alpha = 0
            }
            else {
                sendingButton.alpha = 1
                sendingButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
    fileprivate var consigneeCount: String? {
        get { return consigneeButton.currentTitle }
        set {
            
            if newValue == "0" || newValue == nil {
                consigneeButton.alpha = 0
            }
            else {
                consigneeButton.alpha = 1
                consigneeButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
    fileprivate var evaluationCount: String? {
        get { return evaluationButton.currentTitle }
        set {
            
            if newValue == "0" || newValue == nil {
                evaluationButton.alpha = 0
            }
            else {
                evaluationButton.alpha = 1
                evaluationButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
    fileprivate var userName: String? {
        
        get {
            return displayUserName.currentTitle
        }
        
        set {
            displayUserName.setTitle(newValue, for: .normal)
        }
    }
    
    func updateUI() {
        
        let loginModel = LoginModel.load()!
        
        if Thread.isMainThread == false {
            
            DispatchQueue.main.async {
                self.headerImageView.sd_setImage(with: URL(string: loginModel.faceUrl), placeholderImage: UIImage(named: "log_reg_icon"))
                self.userName = loginModel.user_name
                if self.returnedMoneyButton.alpha != 0 {
                    self.returnedMoneyButton.alpha = 0
                }
                self.submitCount = loginModel.review_num
                self.checkCount = loginModel.confirm_num
                self.sendCount = loginModel.ship_num
                self.consigneeCount = loginModel.receipt_num
                self.evaluationCount = loginModel.assess_num
            }
            return
        }
        
        headerImageView.sd_setImage(with: URL(string: loginModel.faceUrl), placeholderImage: UIImage(named: "log_reg_icon"))
        userName = loginModel.user_name
        if returnedMoneyButton.alpha != 0 {
            returnedMoneyButton.alpha = 0
        }
        submitCount = loginModel.review_num
        checkCount = loginModel.confirm_num
        sendCount = loginModel.ship_num
        consigneeCount = loginModel.receipt_num
        evaluationCount = loginModel.assess_num
        
    }
    
    weak var delegate: MineHeaderViewDelegate?
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var displayUserName: UIButton!
    
    func demoClear() {
        
        submitButton.alpha = 0
        checkButton.alpha = 0
        sendingButton.alpha = 0
        consigneeButton.alpha = 0
        evaluationButton.alpha = 0
        returnedMoneyButton.alpha = 0
      
        headerImageView.image = UIImage(named: "log_reg_icon")
        userName = "请登录"
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
extension LoginModel {
    
    var faceUrl: String {

        return "\(host):\(picPort)/\(objectAddress)\(face_image_url)"
    }
}
