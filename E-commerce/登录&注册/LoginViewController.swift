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
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var headerIcon: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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
        let password = passwordField.text!.encode()
        
        let params = ["user_mobile": userName,
                      "user_password": password]
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.login, params: params) { (value, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let model = LoginModel.modelWithDic(dic: value)
            model?.save()
            self.dismissVC(completion: nil)
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
               updateChineseUIWithTextField(textField: textField, temp: temp)
            }
        }
            
        else {
            updateChineseUIWithTextField(textField: textField, temp: temp)
        }
    }
    
    fileprivate func updateChineseUIWithTextField(textField: UITextField, temp: NSString) {
        
        if textField == userNameField {
            if (textField.text?.characters.count)! >= MaxLength.phoneNumber {
                textField.text = temp.substring(to: MaxLength.phoneNumber)
            }
            
            
            if textField.text == LoginStatus.phone {
                
                headerIcon.sd_setImage(with: URL(string: LoginStatus.faceImageUrl!), placeholderImage: UIImage(named: "log_reg_icon"))
                displayName.text = LoginStatus.name
            }
                
            else {
                headerIcon.image = UIImage(named: "log_reg_icon")
                displayName.text = "请登录"
            }
        }
        else {
            if (textField.text?.characters.count)! >= MaxLength.password {
                textField.text = temp.substring(to: MaxLength.password)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    fileprivate func updateUI() {
        
        userNameField.text = LoginStatus.phone
        if userNameField.text == LoginStatus.phone {
            
            headerIcon.sd_setImage(with: URL(string: LoginStatus.faceImageUrl!), placeholderImage: UIImage(named: "log_reg_icon"))
            displayName.text = LoginStatus.name
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        viewTap(nil)
        return true
    }
}
