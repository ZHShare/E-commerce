
//
//  MedicalProductDemoModel.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import SDWebImage
import MBProgressHUD
enum MedicalProductModel {
    
    static func modelWithResponse(response: [String: Any]?) -> ([ADModel]?,[ButtonModel]?,[PreferentialModel]?,[PackModel]?,[ProductModel]?) {
        
        var hud: MBProgressHUD!
        DispatchQueue.main.async {
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        }
        guard let response = response else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let scroll = data["scroll"] as? [Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let category = data["category"] as? [Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let notice = data["notice"] as? [Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let pack = data["pack"] as? [Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        guard let pros = data["product"] as? [Any] else {
            return (nil,nil,nil,nil,nil)
        }
        
        let adModels = ADModel.models(withArray: scroll)
        let buttonModels = ButtonModel.models(withArray: category)
        let notices = PreferentialModel.models(withArray: notice)
        let packs = PackModel.models(withArray: pack)
        let products = ProductModel.models(withArray: pros)
        
        DispatchQueue.main.async {
            hud?.hide(true)
        }
        return (adModels,buttonModels,notices,packs,products)
    }
}

struct ADModel {
    
    let jump_url: String
    let scroll_pic_name: String
    let image_url: String

    static func models(withArray: [Any]?) -> [ADModel] {
        
        var models = [ADModel]()
        
        guard let withArray = withArray else {
            return models
        }
        
        if withArray.count == 0 { return models }
        
        for dic in withArray {
            
            let model = ECMapping.ace(type: ADModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        
        return models
    }
}

class ProductModel: NSObject {
    
    var product_id: String = ""
    var product_name: String = ""
    var product_image_url: String = ""
    var product_image = ""
    var product_desc: String = ""
    var is_best: String = ""
    var is_promote: String = ""
    var is_new: String = ""
    var is_hot: String = ""
    var image: UIImage = Placeholder.DefaultImage!
    var sell_price: String = ""
    var inventory_num = ""
    var market_price = ""
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let value = value as? NSNumber {
            return super.setValue(value.stringValue, forKey: key)
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\(self) none key \(key)")
    }
    
    static func models(withResponse: [String: Any]?, isNormal: Bool = true) -> [ProductModel]? {
        
        guard let response = withResponse else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 {
            return nil
        }
        
        var models = [ProductModel]()
        for dic in list {
            
            var newDic = dic as! [String: Any]
            if isNormal {
                newDic["image"] = ProductModel.fixImage(imgString: (dic as! [String: Any])["product_image_url"] as! String)
            }
            
            let model = ProductModel()
            model.setValuesForKeys(newDic)
            models.append(model)
        }
        return models
    }

    
    static func models(withArray: [Any]?) -> [ProductModel] {
        
        var models = [ProductModel]()
        
        guard let withArray = withArray else {
            return models
        }
        
        if withArray.count == 0 { return models }
        
        for dic in withArray {
            
            var newDic = dic as! [String: Any]
            newDic["image"] = ProductModel.fixImage(imgString: (dic as! [String: Any])["product_image_url"] as! String)
            let model = ProductModel()
            model.setValuesForKeys(newDic)
            models.append(model)
        }
        return models
    }
    
    fileprivate static func fixImage(imgString: String) -> UIImage {
    
        var img: UIImage?
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: imgString) {
            img = image
        }
        else {
            img = UIImage(urlString: "\(host):\(picPort)/\(objectAddress)\(imgString)")
            SDImageCache.shared().store(img!, forKey: imgString)
        }
        if img == nil { return Placeholder.DefaultImage! }
        
        let width = img!.size.width
        
        let itemWidth = (Screen.width - 6) / 2.0
        
        if width > itemWidth {
            
            let imageWidth = CGFloat(itemWidth-10)
            let imageHeight = imageWidth * img!.size.height / width
            
            let sizeChange = CGSize(width: imageWidth, height: imageHeight)
            
            UIGraphicsBeginImageContext(sizeChange)
            
            //draw resized image on Context
            img!.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
            
            //create UIImage
            img = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext()
        }
        return img!
    }
}


struct PreferentialModel {
    
    let notice_id: String
    let notice_title: String
    let notice_content: String
    let notice_type: String
    let product_id: String
    
    static func models(withArray: [Any]?) -> [PreferentialModel] {
        
        var models = [PreferentialModel]()
        
        guard let withArray = withArray else {
            return models
        }
        
        if withArray.count == 0 { return models }
        
        for dic in withArray {
            
            let model = ECMapping.ace(type: PreferentialModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        return models
    }
    
}

struct PackModel {
    
    let product_id: String
    let product_name: String
    let product_image_url: String
    let product_desc: String

    static func models(withArray: [Any]?) -> [PackModel] {
        
        var models = [PackModel]()
        
        guard let withArray = withArray else {
            return models
        }
        
        if withArray.count == 0 { return models }
        
        for dic in withArray {
            
            let model = ECMapping.ace(type: PackModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        return models
    }
}

struct ButtonModel {
    
    let cat_id: String
    let cat_name: String
    let cat_image_url: String
    
    static func models(withArray: [Any]?) -> [ButtonModel] {
        
        var models = [ButtonModel]()
        
        guard let withArray = withArray else {
            return models
        }
        
        if withArray.count == 0 { return models }
        
        for dic in withArray {
            
            let model = ECMapping.ace(type: ButtonModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        return models
    }
}

