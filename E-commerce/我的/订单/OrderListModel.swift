//
//  OrderListModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
struct OrderListModel {
    
    var isSelected: Bool
    let imageNamed: String
    let productName: String
    let remake: String
    let money: String
    let count: String
    let title: String
    let status: String
    
    static func models() -> [OrderListModel] {
        
        return [OrderListModel(isSelected: false, imageNamed: "product_details_1", productName: "产品包名称：医用传呼系统豪华版湖南一特", remake: "白色 55寸", money: "999", count: "2", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_2", productName: "产品包名称：医用传呼系统乐享版湖南一特", remake: "白色 45寸", money: "2999", count: "1", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_1", productName: "产品包名称：医用传呼系统东郭版湖南一特", remake: "白色 25寸", money: "4999", count: "3", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_3", productName: "产品包名称：医用传呼系统湖南一特", remake: "白色 55寸", money: "3999", count: "4", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_4", productName: "产品包名称：医用传呼系统豪华版湖南一特", remake: "白色 15寸", money: "9999", count: "1", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_1", productName: "产品包名称：医用传呼系统舒适版湖南一特", remake: "白色 95寸", money: "3999", count: "2", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_4", productName: "产品包名称：医用传呼系统自动版湖南一特", remake: "白色 55寸", money: "4999", count: "12", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_2", productName: "产品包名称：医用传呼系统精英版湖南一特", remake: "白色 15寸", money: "2999", count: "2", title: "医用传呼系统豪华版湖南一特", status: "待审核"),
                OrderListModel(isSelected: false, imageNamed: "product_details_3", productName: "产品包名称：医用传呼系统精英版湖南一特", remake: "白色 55寸", money: "1999", count: "2", title: "医用传呼系统豪华版湖南一特", status: "待审核")]
        
    }
}
