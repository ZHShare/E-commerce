//
//  LoginViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var userNameField: UITextField! {
        didSet {
            
            userNameField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            
            passwordField.addTarget(self, action: #selector(textFiledDidChanged(textField:)), for: UIControlEvents.editingChanged)
        }
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
            
            
            print("\(data)")

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
    
    @objc fileprivate func textFiledDidChanged(textField: UITextField) {
     
        if userNameField.text!.characters.count > 10 && passwordField.text!.characters.count > 5 {
            loginButton.isEnabled = true
        }
        else {
            loginButton.isEnabled = false
        }
    }
}
