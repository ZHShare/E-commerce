//
//  ECStroryBoard.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation


enum ECStroryBoard {
    
    
    static func controller<T>(type: T.Type = T.self) -> T {
        
        let className = String(describing: type)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ty = storyboard.instantiateViewController(withIdentifier: className) as? T
        if let ty = ty {
            return ty
        }
        fatalError("can not load nib of \(type)")
    }
    
    static func view<T>(type: T.Type = T.self) -> T {
        
        let nibNamed = String(describing: type)
        let tv = UINib(
            nibName: nibNamed,
            bundle: nil
            ).instantiate(withOwner: nil, options: nil)[0] as? T
        
        if let tv = tv { return tv }
        fatalError("can not load nib of \(type)")
    }
}
