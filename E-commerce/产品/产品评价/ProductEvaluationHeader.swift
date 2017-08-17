//
//  ProductEvaluationHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol ProductEvaluationHeaderDelegate {
    func didClick(sender: UIButton)
}

class ProductEvaluationHeader: UIView
{
    fileprivate var exchangeButton: UIButton!

    weak var delegate: ProductEvaluationHeaderDelegate?
    
    @IBAction func headerClick(sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        delegate?.didClick(sender: sender)
    }

    @IBOutlet var all: UIButton! { didSet { exchangeButton = all } }
    @IBOutlet var good: UIButton!
    @IBOutlet var mid: UIButton!
    @IBOutlet var notGood: UIButton!
    
}
