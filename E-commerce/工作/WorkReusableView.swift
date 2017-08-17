//
//  WorkReusableView.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc public protocol UIResableViewDelegate {
    func didClickArea()
}

class WorkReusableView: UICollectionReusableView {

    var area: String? {
        
        get {
            return displayArea?.currentTitle
        }
        
        set {
            displayArea.setTitle(newValue, for: .normal)
        }
    }
    
    weak var delegate: UIResableViewDelegate?
    
    @IBOutlet weak var displayArea: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBAction func login() {
        
        delegate?.didClickArea()
    }
}
