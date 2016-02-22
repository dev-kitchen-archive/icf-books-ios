//
//  Api.swift
//  icf-books
//
//  Created by Andreas Plüss on 20.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

var dct = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!)
var prodConfigs = dct!["AppConfig_prod"] as! NSDictionary
var apiBaseUrl = prodConfigs["base_url"] as! NSString

func idFromUrl(urlString:String) -> String {
    let strWithoutExtension = urlString.stringByReplacingOccurrencesOfString(".json", withString: "")
    let strWithoutSlashes = strWithoutExtension.stringByReplacingOccurrencesOfString("/", withString: "")

    let nsstring = strWithoutSlashes as NSString
    let nsrange = NSRange.init(location: strWithoutSlashes.characters.count - 36, length: 36)

    //let index = strWithoutSlashes.endIndex.
    
    let id = nsstring.substringWithRange(nsrange)
    return id as String
}