//
//  NotificationCenter.swift
//  device
//
//  Created by 王雄皓 on 2017/5/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

public protocol Nofifier {
    associatedtype Notification: RawRepresentable
}

public extension Nofifier where Notification.RawValue == String {
    
    private static func nameFor(notification: Notification) -> String {
        return "\(self).\(notification.rawValue)"
    }
    
    func postNotification(notification: Notification, object: AnyObject? = nil) {
        Self.postNotification(notification: notification, object: object)
    }
    
    func postNotification(notification: Notification, object: AnyObject? = nil, userInfo: [AnyHashable : AnyObject]? = nil) {
        Self.postNotification(notification: notification, object: object, userInfo: userInfo)
    }
    
    
    // MARK: - Static Function
    
    // Post
    
    static func postNotification(notification: Notification, object: AnyObject? = nil, userInfo: [AnyHashable : AnyObject]? = nil) {
        let name = nameFor(notification: notification)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
    }
    
    // Add
    
    static func addObserver(observer: AnyObject, selector: Selector, notification: Notification) {
        let name = nameFor(notification: notification)
        
        NotificationCenter.default
            .addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    // Remove
    
    static func removeObserver(observer: AnyObject, notification: Notification, object: AnyObject? = nil) {
        let name = nameFor(notification: notification)
        
        NotificationCenter.default
            .removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
    }
    
}
