//
//  SystemKit.swift
//  yuro_plugin
//
//  Created by 杜刚 on 2023/7/13.
//
import Flutter
import Foundation
import WebKit

class SystemKit: NSObject{
    static let instance = SystemKit()
    
    private override init() {}
    
    func deviceInfo(result: @escaping FlutterResult){
        var iosInfo = [String: Any?]()
        //应用程序信息
        let  infoDictionary =  Bundle .main.infoDictionary!
        iosInfo["packageName"] = infoDictionary[ "CFBundleIdentifier" ]
      
        iosInfo["brand"] = UIDevice.current.systemName
        iosInfo["model"] = UIDevice.current.model
        iosInfo["sdk"] = UIDevice.current.systemVersion
        iosInfo["userAgent2"] = WKWebView().value(forKey: "userAgent")
        iosInfo["udid"] = UIDevice.current.identifierForVendor?.uuidString
        
        result(iosInfo)
    }
}
