//
//  ResetViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ResetViewController: BaseViewController
{
    
    var phoneNumber: String!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var surePwdField: UITextField! { didSet { textFieldAddEdidtingChanged(textField: surePwdField) } }
    @IBOutlet weak var newPwdField: UITextField!  { didSet { textFieldAddEdidtingChanged(textField: newPwdField) } }
    
    @IBAction func tapNewPwdView(_ sender: Any) {
        
        surePwdField.isEnabled = false
        
        newPwdField.isEnabled = true
        newPwdField.becomeFirstResponder()
    }
    
    @IBAction func tapSurePwdView(_ sender: Any) {
        
        newPwdField.isEnabled = false
        
        surePwdField.isEnabled = true
        surePwdField.becomeFirstResponder()
    }
    
    @IBAction func reset() {
        
        let pars = ["user_mobile": phoneNumber,
                      "user_password": newPwdField.text!.encode()]
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.resetPassword, params: pars) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            LoginStatus.updatePhone(phone: self.phoneNumber)
            self.navigationController?.ecPopToRootViewController()
        }
        
    }
    
    fileprivate func textFieldAddEdidtingChanged(textField: UITextField) {
        textField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    
    fileprivate enum MaxLength {
        static let password = 16
    }
    
    @objc fileprivate func textFiledDidChanged(textField: UITextField) {
        
        
        if surePwdField.text!.characters.count > 5 && newPwdField.text == surePwdField.text {
            
            resetButton.isEnabled = true
        }
            
        else {
            resetButton.isEnabled = false
        }
        
        
        guard let text = textField.text  else { return }
        
        let temp = text as NSString
        
        let lang = textField.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = textField.markedTextRange
            
            if range == nil {
                
                if (textField.text?.characters.count)! >= MaxLength.password {
                    textField.text = temp.substring(to: MaxLength.password)
                }
                
            }
            
        }
            
        else {
            
            if (textField.text?.characters.count)! >= MaxLength.password {
                textField.text = temp.substring(to: MaxLength.password)
            }
        }
    }
    
}
// MARK: UITextFieldDelegate
extension ResetViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        surePwdField.isEnabled = false
        newPwdField.isEnabled = false
        
        return true
    }
    
}

