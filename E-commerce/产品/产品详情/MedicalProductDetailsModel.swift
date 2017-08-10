//
//  MedicalProductDetailsModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

class MedicalProductDetailsModel: NSObject {
    
    var product_id: String = ""
    var product_name: String = ""
    var inventory_num: String = ""
    var product_sold: String = ""
    var weight: String = ""
    var shipping_price: String = ""
//    var delivery_place: String = ""
    var sell_price: String = ""
    var market_price: String = ""
    var review_count: String = ""
    var delivery_plac: String = ""
    var product_desc: String = ""
    var product_image_url: String = ""
    
    var scrolls: [Scroll]?
    var attrs: [Attr]?
    var reviews: [Review]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let value = value as? NSNumber {
            return super.setValue(value.stringValue, forKey: key)
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        switch key {
        case "scroll": scrolls = Scroll.models(withArr: value as? [Any])
        case "attr": attrs = Attr.models(withArr: value as? [Any])
        case "review": reviews = Review.models(withArr: value as? [Any])
        default:
            print("none key:\(key)")
        }
        
    }
    
    struct Scroll {
        
        let pic_desc: String
        let pic_url: String

        static func models(withArr: [Any]?) -> [Scroll]? {
            
            if let arr = withArr {
                
                if arr.count > 0 {
                    
                    var models = [Scroll]()
                    for dic in arr {
                        let model = ECMapping.ace(type: Scroll.self, fromDic: dic as! [String: Any])
                        models.append(model)
                    }
                    return models
                }
                            }
            return nil
        }
        
    }
    
    class Attr: NSObject {
        
        var attr_name: String = ""
        var attr_id: String = ""
        var attr_desc: String = ""
        var subAttrs: [SubAttrVal]?
        
        override func setValue(_ value: Any?, forKey key: String) {
            if let value = value as? NSNumber {
                return super.setValue(value.stringValue, forKey: key)
            }
            super.setValue(value, forKey: key)
        }
        
        override func setValue(_ value: Any?, forUndefinedKey key: String) {
            if key == "sub_attr_val"  {
                subAttrs = SubAttrVal.models(withArr: value as? [Any])
            }
        }
        
        static func models(withArr: [Any]?) -> [Attr]? {
            
            if let arr = withArr {
                
                if arr.count > 0 {
                    
                    var models = [Attr]()
                    for dic in arr {
                        
                        let model = Attr()
                        model.setValuesForKeys(dic as! [String : Any])
                        models.append(model)
                    }
                    return models
                }
            }
            return nil
        }
    }
    
    struct SubAttrVal {
        
        let attr_value: String
        let attr_value_desc: String
        var isSelected: Bool
        
        static func models(withArr: [Any]?) -> [SubAttrVal]? {
            
            if let arr = withArr {
                
                if arr.count > 0 {
                    
                    var models = [SubAttrVal]()
                    for dic in arr {
                        
                        var newDic = dic as! [String: Any]
                        newDic["isSelected"] = false
                        let model = ECMapping.ace(type: SubAttrVal.self, fromDic: newDic)
                        models.append(model)
                    }
                    return models
                }
            }
            return nil
        }
    }
    
    struct Review {
        
        let user_name: String
        let user_id: String
        let face_image_url: String
        let content: String
        let add_time: String
        let comment_rank: String

        static func models(withArr: [Any]?) -> [Review]? {
            
            if let arr = withArr {
                
                if arr.count > 0 {
                    
                    var models = [Review]()
                    for dic in arr {
                        let model = ECMapping.ace(type: Review.self, fromDic: dic as! [String: Any])
                        models.append(model)
                    }
                    return models
                }
            }
            return nil
        }
    }
    
    struct SectionOne {
        var title: String
        
        static func models() -> [SectionOne] {
            
            return [SectionOne(title: "选择型号数量")]
        }
    }
    
    
    static func model(withDic: [String: Any]?) -> MedicalProductDetailsModel? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        let model = MedicalProductDetailsModel()
        model.setValuesForKeys(data)
        return model
    }
   
    
}
