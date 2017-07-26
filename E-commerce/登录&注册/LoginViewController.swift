//
//  LoginViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController
{
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer?) {
        
        if userNameField.isFirstResponder {
            userNameField.resignFirstResponder()
        }
        
        if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
        }
        
        if userNameField.isEnabled {
            userNameField.isEnabled = false
        }
        
        if passwordField.isEnabled {
            passwordField.isEnabled = false
        }
        
    }
    
    @IBOutlet weak var userNameField: UITextField! {
        didSet {
            
            userNameField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
            userNameField.isEnabled = false
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            
            passwordField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
            passwordField.isEnabled = false
        }
    }
    
    @IBAction func tapPasswordView(_ sender: Any) {
        
        if userNameField.isFirstResponder {
            userNameField.resignFirstResponder()
        }
        
        if userNameField.isEnabled {
            userNameField.isEnabled = false
        }
        
        passwordField.isEnabled = true
        passwordField.becomeFirstResponder()
    }
    
    @IBAction func tapUserNameView(_ sender: Any) {
        
        if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
        }
        
        if passwordField.isEnabled {
            passwordField.isEnabled = false
        }
        
        userNameField.isEnabled = true
        userNameField.becomeFirstResponder()
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login() {
        
        let userName = userNameField.text!
        let password = passwordField.text!
        
        let params = ["user": userName,
                      "password": password]
        
        ECHud.show()
        HNet.request(method: "GET", url: "http://localhost:8080", form: params as Dictionary<String, AnyObject>, success: { (data) in
            
            if let user = ECModelManager.modelWithType(type: LoginModel.self, data: data) {
                
                user.save()
                
                print("\(user)\n\(user.name)\n\(user.user_id)")
            }
            
            DispatchQueue.main.async { [unowned self] in
                
                self.dismiss(animated: true, completion: nil)
                ECHud.hidden()
            }
            
            
        }) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    fileprivate enum MaxLength {
        static let phoneNumber = 11
        static let password = 16
    }
    
    @objc fileprivate func textFiledDidChanged(textField: UITextField) {
        
        if userNameField.text!.characters.count > 10 && passwordField.text!.characters.count > 1 {
            loginButton.isEnabled = true
        }
        else {
            loginButton.isEnabled = false
        }
       
        guard let text = textField.text  else { return }
        
        let temp = text as NSString
        
        let lang = textField.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = textField.markedTextRange
            
            if range == nil {
                
                if textField == userNameField {
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
            
            if textField == userNameField {
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
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        viewTap(nil)
        return true
    }
}
