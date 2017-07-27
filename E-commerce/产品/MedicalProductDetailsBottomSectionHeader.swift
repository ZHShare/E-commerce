//
//  MedicalProductDetailsBottomSectionHeader.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

protocol MedicalProductDetailsBottomSectionHeaderDelegate {
    func didClick(sender: UIButton)
}

class MedicalProductDetailsBottomSectionHeader: UIView
{
    @IBOutlet weak var detailsButton: UIButton! { didSet { setupDefault() } }

    fileprivate var centerButton: UIButton?
    fileprivate func setupDefault() {
        detailsButton.isSelected = true
        centerButton = detailsButton
    }
    
    
    var delegate: MedicalProductDetailsBottomSectionHeaderDelegate?
    
    
    @IBAction fileprivate func setCurrent(sender: UIButton) {
        centerButton?.isSelected = false
        centerButton = sender
        centerButton?.isSelected = true
        
        delegate?.didClick(sender: sender)
    }
  
}
// MARK: - How to initialise a UIView Class with a xib file in Swift
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
