//
//  MyFavoriteModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MyFavoriteModel {
    
    let imageNamed: String
    let productName: String
    let price: String
    
    static func models() -> [MyFavoriteModel] {
        return [MyFavoriteModel(imageNamed: "product_details_1", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "1888"),
         MyFavoriteModel(imageNamed: "product_details_2", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "1889"),
         MyFavoriteModel(imageNamed: "product_details_3", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "1886"),
         MyFavoriteModel(imageNamed: "product_details_4", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "188"),
         MyFavoriteModel(imageNamed: "product_details_1", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "1848"),
         MyFavoriteModel(imageNamed: "product_details_2", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "1858"),
         MyFavoriteModel(imageNamed: "product_details_3", productName: "产品包名称：医用传呼系统乐享版湖南一特", price: "18388")]
    }
}

struct MyFavoriteTypeModel {
    
    let title: String
    
    static func models() -> [MyFavoriteTypeModel] {
        
        return [MyFavoriteTypeModel(title: "传呼类"),
         MyFavoriteTypeModel(title: "护理系统"),
         MyFavoriteTypeModel(title: "制氧机"),
         MyFavoriteTypeModel(title: "工程设计"),
         MyFavoriteTypeModel(title: "工程产品")]
    }
}
