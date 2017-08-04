//
//  MineDetailsChangeViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineDetailsChangeViewController: BaseViewController
{

    var name: String? {
        didSet { updateUI() }
    }
    var done: ((String) -> Void)?
    @IBOutlet weak var nameField: UITextField!
    fileprivate let maxLength = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        updateUI()
    }
    
    fileprivate func updateUI() {
        
        nameField?.text = name
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        
        let lang = sender.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = sender.markedTextRange
            
            if range == nil {
                
                if sender.text!.length >= maxLength {
                    sender.text = (sender.text! as NSString).substring(to: maxLength)
                }
                
            }
            
        }
        else {
            
            if sender.text!.length >= maxLength {
                sender.text = (sender.text! as NSString).substring(to: maxLength)
            }
        }
    }
    
    
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "修改姓名"
        
        let doneItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneAction))
        doneItem.tintColor = .black
        navigationItem.rightBarButtonItem = doneItem
    }
    
    @objc fileprivate func doneAction() {
        
        let loginModel = LoginModel.load()!
        let params = ["user_id": loginModel.user_id,
                      "user_name": nameField.text!]
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.change, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            if let done = self.done {
                
                self.navigationController?.ecPopViewController()
                LoginModel.update(key: "user_name", value: self.nameField.text!)
                done(self.nameField.text!)
            }
        }
        
        
    }
}
