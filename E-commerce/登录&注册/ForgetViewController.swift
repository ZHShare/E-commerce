//
//  ForgetViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ForgetViewController: BaseViewController
{
    
    fileprivate var timer: Timer?
    fileprivate var count = 60
    fileprivate let max = 60
    
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
        phoneNumberField.isEnabled = false
        codeField.isEnabled = false
    }
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var codeField: UITextField! { didSet{ textFieldAddEdidtingChanged(textField: codeField) } }
    @IBOutlet weak var phoneNumberField: UITextField! { didSet{ textFieldAddEdidtingChanged(textField: phoneNumberField) } }
    
    @IBOutlet weak var fetchCodeButton: UIButton!
   
    @IBAction func tapPhoneNumberView(_ sender: Any) {

        if codeField.isEnabled {
            codeField.isEnabled = false
        }
        
        phoneNumberField.isEnabled = true
        phoneNumberField.becomeFirstResponder()
    }
    
    @IBAction func tapPasswordView(_ sender: Any) {
        
        if phoneNumberField.isEnabled {
            phoneNumberField.isEnabled = false
        }
        
        codeField.isEnabled = true
        codeField.becomeFirstResponder()
    }
    
    @IBAction func fetchCode(_ sender: UIButton) {
        
        phoneNumberField.resignFirstResponder()
        phoneNumberField.isEnabled = false
        
        codeField.isEnabled = true
        codeField.becomeFirstResponder()
        
        let params = ["user_mobile": phoneNumberField.text!,
                      "busi_type": "02",
                      "templateId": "6833"]
        
        PubNet.fetchDataWith(transCode: TransCode.Pub.sendCode, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            super.hudWithMssage(msg: "验证码已发送")
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
            self.timerAction()
        }
        
    }
    
    @IBAction func next() {
        
        PubNet.fetchDataWith(transCode: TransCode.Pub.codeVerify, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let resetViewController = ECStroryBoard.controller(type: ResetViewController.self)
            resetViewController.phoneNumber =  self.phoneNumberField.text!
            self.navigationController?.ecPushViewController(resetViewController)
        }
    }
    
    fileprivate var params: [String: Any] {
        return ["user_mobile": phoneNumberField!.text!,
                "busi_type": "02",
                "sms_code": codeField.text!]
    }
    
    @objc fileprivate func timerAction() {
        
        count -= 1
        fetchCodeButton.setTitle("\(count)秒后可重发", for: UIControlState.normal)
        
        if count == 0 {
            
            fetchCodeButton.setTitle("获取验证码", for: UIControlState.normal)
            count = max
            timer?.invalidate()
            timer = nil
            return
        }
        
    }
    
    fileprivate func textFieldAddEdidtingChanged(textField: UITextField) {
        textField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    
    fileprivate enum MaxLength {
        static let phoneNumber = 11
        static let password = 6
    }
    
    @objc fileprivate func textFiledDidChanged(textField: UITextField) {
       
        
        if phoneNumberField.text!.characters.count > 10 && codeField.text!.characters.count > 0 {
            
            registerButton.isEnabled = true
        }
            
        else {
            registerButton.isEnabled = false
        }
        
        
        if phoneNumberField.text!.characters.count > 10 {
            
            fetchCodeButton.isEnabled = true
        }
            
        else {
            fetchCodeButton.isEnabled = false
        }
       
        guard let text = textField.text  else { return }
        
        let temp = text as NSString
        
        let lang = textField.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = textField.markedTextRange
            
            if range == nil {
                
                if textField == phoneNumberField {
                    if (textField.text?.characters.count)! >= MaxLength.phoneNumber {
                        textField.text = temp.substring(to: MaxLength.phoneNumber)
                    }
                }
                else {
                    if (textField.text?.characters.count)! >= MaxLength.password {
                        textField.text = temp.substring(to: MaxLength.password)
                    }
                }
            }
            
        }
            
        else {
            
            if textField == phoneNumberField {
                if (textField.text?.characters.count)! >= MaxLength.phoneNumber {
                    textField.text = temp.substring(to: MaxLength.phoneNumber)
                }
            }
            else {
                if (textField.text?.characters.count)! >= MaxLength.password {
                    textField.text = temp.substring(to: MaxLength.password)
                }
            }
        }
        
        
    }
    
}
// MARK: UITextFieldDelegate
extension ForgetViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        phoneNumberField.isEnabled = false
        codeField.isEnabled = false
        
        return true
    }
    
}
