//
//  ECMJRefresh.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import MJRefresh

public struct ECMJRefresh {
    
    static var footer: MJRefreshAutoNormalFooter {
        get {
            return MJRefreshAutoNormalFooter()
        }
    }
    
    static var header: MJRefreshNormalHeader {
        get {
            
            return MJRefreshNormalHeader()
        }
    }
    
    func gifHeader() -> MJRefreshGifHeader {
        
        let header = MJRefreshGifHeader()
        header.backgroundColor = UIColor.groupTableViewBackground
        
        
        let idleImages = [UIImage(named: "box") ?? UIImage(),UIImage(named: "staticDeliveryStaff") ?? UIImage()]
        let refreshingImages = [UIImage(named: "deliveryStaff0") ?? UIImage(),
                                UIImage(named: "deliveryStaff1") ?? UIImage(),
                                UIImage(named: "deliveryStaff2") ?? UIImage(),
                                UIImage(named: "deliveryStaff3") ?? UIImage()]
        
        header.setImages(idleImages, for: MJRefreshState.idle)
        header.setImages(refreshingImages, for: MJRefreshState.refreshing)
        
        return header
    }
}
