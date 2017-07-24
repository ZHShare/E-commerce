//
//  ProductHeader.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductHeader: UIView {
    var contentView:UIView!
    
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBAction func more() {
    }

//    //初始化时将xib中的view添加进来
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView = loadViewFromNib()
//        addSubview(contentView)
//        addConstraints()
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//
//        super.init(coder: aDecoder)
//        contentView = loadViewFromNib()
//        addSubview(contentView)
//        addConstraints()
//    }
//    
    
    //加载xib
    func loadViewFromNib() -> UIView {
        
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
//        let nib = UINib(nibName: name!, bundle: bundle)
        
        let view = Bundle.main.loadNibNamed(name!, owner: nil, options: nil)?.first as! UIView
        return view
    }
    //设置好xib视图约束
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }

}
