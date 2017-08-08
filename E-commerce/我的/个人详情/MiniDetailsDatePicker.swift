//
//  MiniDetailsDatePicker.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import EZSwiftExtensions

enum ECDateType {
    case Default
    case Day
}

class MiniDetailsDatePicker: UIView
{
    fileprivate var date: String = Date().toString(format: "yyyy-MM-dd")
    @IBAction func tapAction(_ sender: Any) {
        hidden()
    }
    
    var dateChose: ((String) -> Void)?
    
    var type: ECDateType = .Default {
        didSet { updateUI() }
    }
    
    fileprivate var years: [String] {
        
        var newYears = [String]()
        for index in 2010...2030 {
            newYears.append("\(index)年")
        }
        return newYears
    }
    
    fileprivate var months: [String] {
        
        var newMonths = [String]()
        for index in 1..<13 {
            newMonths.append("\(index)月")
        }
        return newMonths
    }
    
    fileprivate var currntYear = "2010"
    fileprivate var currentMonth = "01"
    
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
    
    fileprivate func updateUI() {
        
        let newFrame = picker.frame
        let superView = picker.superview
        picker.removeFromSuperview()
        picker = nil
        
        let pickerView = UIPickerView(frame: newFrame)
        superView?.addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    @IBAction func cancel() {
        
        hidden()
    }
    
    @IBAction func sure() {
        hidden()
        
        if picker != nil {
            if let dateChose = dateChose {
                dateChose(date)
            }
        }
        
        else {
            if let dateChose = dateChose {
                dateChose("\(currntYear)\(currentMonth)")
            }
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
        date = picker.date.toString(format: "yyyyMMdd")
    }
}
extension MiniDetailsDatePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return component == 0 ? years.count : months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return Screen.width / 2.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            let year = years[row]
            currntYear = year.toNSString.replacingOccurrences(of: "年", with: "")
        }
        else {
            let month = months[row]
            currentMonth = month.toNSString.replacingOccurrences(of: "月", with: "")
            if currentMonth.length == 1 {
                currentMonth = "0\(currentMonth)"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return years[row]
        }
        return months[row]
    }
}

