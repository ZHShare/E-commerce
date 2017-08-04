//
//  File.swift
//  device
//
//  Created by YE on 2017/3/16.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import CryptoSwift

enum DataEncoding {
    
    fileprivate static let key = "7856412346543216"
    fileprivate static let iv  = "8888888888888888"
    
    //AES-ECB128加密
    static func Endcode_AES_ECB(_ strToEncode: String )-> String
    {
        
        guard let ps = strToEncode.data(using: String.Encoding.utf8) else {
            assert(true, "\(strToEncode) 无法转换成data")
            return ""
        }
        
        var encrypted: [UInt8] = []
       
        do {
            
            var encryptor = try AES(key: key, iv: iv).makeEncryptor()
            encrypted = try encryptor.finish(withBytes: ps.bytes)
            
        } catch _ {
            print(Error.self)
        }
        
        let encoded = Data(bytes: encrypted)
        
        return encoded.base64EncodedString()
    }
    
    //AES-ECB128解密
    static func Decode_AES_ECB(_ strToDecode:String) -> String
    {
        guard let data = Data.init(base64Encoded: strToDecode) else {
            assert(true, "\(strToDecode) 无法转换成data")
            return ""
        }
        
        var decrypted: [UInt8] = []
        
        do {
            
            var decryptor = try AES(key: key, iv: iv).makeDecryptor()
            decrypted = try decryptor.finish(withBytes: data.bytes)
            
        } catch _ {
            print(Error.self)
        }
        
        let encoded = Data(bytes: decrypted)
        guard let str = String.init(data: encoded, encoding: String.Encoding.utf8) else {
            assert(true, "无法转换为字符串")
            return ""
        }
        
        return str
    }
    
}
extension String {
    
    func encode() -> String {
        return DataEncoding.Endcode_AES_ECB(self)
    }
    
    func decode() -> String {
        return DataEncoding.Decode_AES_ECB(self)
    }
}

