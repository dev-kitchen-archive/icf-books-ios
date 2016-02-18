//
//  ParseMedia.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class ParseMedia {
    var passedDict: NSDictionary
    
    init(retrievedDictFromGetJson retrievedData: NSDictionary){
        passedDict = retrievedData
    }
    
    static func fromJson(dict: NSDictionary) {
        
        let id = dict.objectForKey("id") as! String
        let type = dict.objectForKey("type") as! String
        let title = dict.objectForKey("title") as! String
        let teaser = dict.objectForKey("teaser") as! String
        let thumbnailUrl = dict.objectForKey("thumbnail_url") as! String
        
        let mediaData = dict.objectForKey("data") as! NSDictionary
        let fileUrl = mediaData.objectForKey("file_url") as! String
        
        print(id)
        print(type)
        print(title)
        print(teaser)
        print(thumbnailUrl)
        print(fileUrl)
    }
}