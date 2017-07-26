//
//  ECCommon.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import UIKit

public enum Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

public enum ECCommon {
    
    static func heightForImage(image: UIImage) -> CGFloat {
        
        let size = image.size
        
        let scale = Screen.width / size.width
        let imageHeight = size.height * scale
        
        return imageHeight
    }
}
