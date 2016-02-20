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
