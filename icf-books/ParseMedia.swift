//
//  ParseMedia.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class ParseMedia {
    
    static func fromJson(dict: NSDictionary) -> [String: AnyObject]? {
        
        var returnData: [String: AnyObject]? = nil
        
        let id = dict.objectForKey("id") as? String
        let type = dict.objectForKey("type") as? String
        let title = dict.objectForKey("title") as? String
        let teaser = dict.objectForKey("teaser") as? String
        let thumbnailUrl = dict.objectForKey("thumbnail_url") as? String
        
        print(thumbnailUrl)
        print(id)
        print(type)
        print(title)
        print(teaser)
        
        if MediaType.getFrom(string: type!) != nil {
            //get thumbnail image
            let url = NSURL(string: thumbnailUrl!)
            let imageData = NSData(contentsOfURL: url!)
            
            //put together data type specific
            let mediaTypeDict = dict.objectForKey("data") as! NSDictionary

            let typeData : NSData = NSKeyedArchiver.archivedDataWithRootObject(mediaTypeDict)
            
            returnData = ["id": id!, "type": type!, "title": title!, "teaser": teaser!, "thumbnailData": imageData!, "typeData": typeData]
        }
        
        return returnData
    }
    

    

}