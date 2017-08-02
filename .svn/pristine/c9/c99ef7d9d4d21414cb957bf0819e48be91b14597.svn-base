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

    var done: ((String) -> Void)?
    @IBOutlet weak var nameField: UITextField!
    fileprivate let maxLength = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
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
        
        if let done = done {
            navigationController?.ecPopViewController()
            done(nameField.text!)
        }
    }
}
