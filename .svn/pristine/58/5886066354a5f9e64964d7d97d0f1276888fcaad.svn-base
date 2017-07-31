//
//  RegisterViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController
{
    fileprivate var fileds = [UITextField]()
    @IBOutlet weak var displayRedTip: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func tapView(_ sender: Any?) {
        
        resignFirstResponderWithExitTextField(textField: nil)
    }
    @IBOutlet weak var phoneField: UITextField! { didSet { filedDefault(textField: phoneField) } }
    
    @IBOutlet weak var nameField: UITextField! { didSet { filedDefault(textField: nameField) } }
    
    @IBOutlet weak var delegateField: UITextField! { didSet { textFieldAddEdidtingChanged(textField: delegateField) } }
    
    @IBOutlet weak var passwordField: UITextField! { didSet { filedDefault(textField: passwordField) } }
    
    @IBOutlet weak var sureField: UITextField! { didSet { filedDefault(textField: sureField) } }
    
    @IBAction func register() {
        
    }
    @IBAction func tapPhoneNumberView(_ sender: UITapGestureRecognizer) {
        
        resignFirstResponderWithExitTextField(textField: phoneField)
    }

    @IBAction func tapSurePwdView(_ sender: UITapGestureRecognizer) {
        
        resignFirstResponderWithExitTextField(textField: sureField)
        sureField.addTarget(self, action: #selector(passwordDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @IBAction func tapPwdView(_ sender: UITapGestureRecognizer) {
        
        resignFirstResponderWithExitTextField(textField: passwordField)
        passwordField.addTarget(self, action: #selector(passwordDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @IBAction func tapNameView(_ sender: UITapGestureRecognizer) {
        
        resignFirstResponderWithExitTextField(textField: nameField)
    }
    
    @IBAction func tapDelegateView(_ sender: UITapGestureRecognizer) {
        
        resignFirstResponderWithExitTextField(textField: nil)
        print("跳转")
        delegateField.text = "华北区总代理"
    }
    
    fileprivate func resignFirstResponderWithExitTextField(textField: UITextField?) {

        if let textField = textField {
            textFieldAddEdidtingChanged(textField: textField)
        }
        
        for field in fileds {
            
            if field == textField {
                field.isEnabled = true
                field.becomeFirstResponder()
                continue
            }
            
            field.isEnabled = false
            field.resignFirstResponder()
        }
    }
    
    
    fileprivate func filedDefault(textField: UITextField) {
        textField.isEnabled = false
        fileds.append(textField)
    }

    fileprivate func textFieldAddEdidtingChanged(textField: UITextField) {
         textField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    @objc fileprivate func passwordDidChanged(textField: UITextField) {
    
        if passwordField.text != sureField.text {
            displayRedTip.text = "两次密码输入不一致"
            
        }
        
        else {
            displayRedTip.text = ""
        }
    }
    
    fileprivate enum MaxLength {
        static let phoneNumber = 11
        static let password = 16
        static let name = 6
    }
    
    @objc fileprivate func textFiledDidChanged(textField: UITextField) {
        
        var bool = true
        for field in fileds {
            
            if field.text!.characters.count == 0 {
                bool = false
            }
        }
        
        if bool && delegateField!.text!.characters.count > 0 && passwordField.text == sureField.text {
            
            registerButton.isEnabled = true
        }
        
        else {
            registerButton.isEnabled = false
        }
        
        
        
       
        guard let text = textField.text  else { return }
        
        let temp = text as NSString
        
        let lang = textField.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = textField.markedTextRange
            
            if range == nil {
                
                if textField == phoneField {
                    if (textField.text?.characters.count)! >= MaxLength.phoneNumber {
                        textField.text = temp.substring(to: MaxLength.phoneNumber)
                    }
                }
                else if textField == passwordField || textField == sureField {
                    if (textField.text?.characters.count)! >= MaxLength.password {
                        textField.text = temp.substring(to: MaxLength.password)
                    }
                }
                
                else {
                    
                    if (textField.text?.characters.count)! >= MaxLength.name {
                        textField.text = temp.substring(to: MaxLength.name)
                    }
                }
            }
            
        }
            
        else {
            
            if textField == phoneField {
                if (textField.text?.characters.count)! >= MaxLength.phoneNumber {
                    textField.text = temp.substring(to: MaxLength.phoneNumber)
                }
            }
            else if textField == passwordField || textField == sureField {
                if (textField.text?.characters.count)! >= MaxLength.password {
                    textField.text = temp.substring(to: MaxLength.password)
                }
            }
                
            else {
                
                if (textField.text?.characters.count)! >= MaxLength.name {
                    textField.text = temp.substring(to: MaxLength.name)
                }
            }
        }
    }
}
// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        tapView(nil)
        return true
    }
}
