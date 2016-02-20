//
//  ParseMedia.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class ParseMedia {
    static let baseUrl = "https://rhino.dev.kitchen"
    
    static func fromJson(dict: NSDictionary) -> [String: AnyObject] {
        let id = dict.objectForKey("id") as! String
        let type = dict.objectForKey("type") as! String
        let title = dict.objectForKey("title") as! String
        let teaser = dict.objectForKey("teaser") as! String
        let thumbnailUrl = dict.objectForKey("thumbnail_url") as! String
        
        let mediaData = dict.objectForKey("data") as! NSDictionary
        let fileUrl = mediaData.objectForKey("file_url") as! String
        
        //get thumbnail image
        let url = NSURL(string: baseUrl + thumbnailUrl)
        let imageData = NSData(contentsOfURL: url!)
        
        let returnData: [String: AnyObject] = ["id": id, "type": type, "title": title, "teaser": teaser, "thumbnailUrl": thumbnailUrl, "thumbnailData": imageData!, "fileUrl": fileUrl]
        
        return returnData
    }

}