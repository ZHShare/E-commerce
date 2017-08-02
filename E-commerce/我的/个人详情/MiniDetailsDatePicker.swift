//
//  MiniDetailsDatePicker.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class MiniDetailsDatePicker: UIView
{
    fileprivate var date: String = Date().toString(format: "yyyy-MM-dd")
    @IBAction func tapAction(_ sender: Any) {
        hidden()
    }
    
    var dateChose: ((String) -> Void)?
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = UIScreen.main.bounds
        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.show()
        }
    }

    @IBAction func cancel() {
        
        hidden()
    }
    
    @IBAction func sure() {
        hidden()
        if let dateChose = dateChose {
            dateChose(date)
        }
    }

    fileprivate func show() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.bottomView.frame.origin.y = Screen.height-250
            self.bgView.alpha = 0.5
        }, completion: nil)
    }
    
    fileprivate func hidden() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.bottomView.frame.origin.y = Screen.height
            self.bgView.alpha = 0
        }) { (flag) in
            
            self.removeFromSuperview()
        }
    }
    
    @IBOutlet var picker: UIDatePicker!
    
    
    @IBAction func pickerDidChanged() {
        date = picker.date.toString(format: "yyyy-MM-dd")
    }
}
