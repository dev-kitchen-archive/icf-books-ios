//
//  Api.swift
//  icf-books
//
//  Created by Andreas Plüss on 20.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class Api {
    static let dct = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!)
    static let prodConfigs = dct!["AppConfig_prod"] as! NSDictionary
    static var baseUrl = prodConfigs["base_url"] as! String
    static var buyUrl = prodConfigs["buy_book_url"] as! String
    static var storeUrl = prodConfigs["store_url"] as! String
    static var devUrl = prodConfigs["dev_url"] as! String
    static var fontis = prodConfigs["fontis_url"] as! String
    static var impressum = prodConfigs["impressum_url"] as! String
    
    
    static func idFromUrl(urlString:String) -> String {
        let strWithoutExtension = urlString.stringByReplacingOccurrencesOfString(".json", withString: "")
        let strWithoutSlashes = strWithoutExtension.stringByReplacingOccurrencesOfString("/", withString: "")
        
        let nsstring = strWithoutSlashes as NSString
        let nsrange = NSRange.init(location: strWithoutSlashes.characters.count - 36, length: 36)
        
        let id = nsstring.substringWithRange(nsrange)
        return id as String
    }
    
    static func getLanguageUrl() -> String {
        if NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode)! as! String == "de" {
            return baseUrl + "/de"
        } else {
            return baseUrl + "/en"
        }
    }

}