//
//  ParseMedia.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class ParseMedia {
    static let baseUrl = Api.baseUrl
    
    static func fromJson(dict: NSDictionary) -> [String: AnyObject]? {
        var returnData: [String: AnyObject]? = nil
        if let id = dict.objectForKey("id") as? String {
            let type = dict.objectForKey("type") as! String
            let title = dict.objectForKey("title") as! String
            let teaser = dict.objectForKey("teaser") as! String
            let thumbnailUrl = dict.objectForKey("thumbnail_url") as! String
            
            //get thumbnail image
            let url = NSURL(string: baseUrl + thumbnailUrl)
            let imageData = NSData(contentsOfURL: url!)
            
            //put together data type specific
            let mediaData = dict.objectForKey("data") as! NSDictionary
            var typeSpecificData:[String:AnyObject]
            if type == "movie" {
                //some of the data is redundant on purpose, as the data above is needed
                //as meta data (for cell title etc) and the following data is needed for the
                //detail view
                let fileUrl = mediaData.objectForKey("file_url") as! String
                typeSpecificData = ["title":title, "description":teaser, "thumbnail":imageData!, "video_url":fileUrl]
            } else if type == "two_movies_and_text" {
                
                let dataMove1 = mediaData.objectForKey("movie1_url") as! String
                let dataMove2 = mediaData.objectForKey("movie2_url") as! String
                let dataDesc1 = mediaData.objectForKey("description1") as! String
                let dataDesc2 = mediaData.objectForKey("description2") as! String
                
                typeSpecificData = ["title":title, "description1":dataDesc1, "description2":dataDesc2, "thumbnail":imageData!, "video_url1":dataMove1, "video_url2":dataMove2]
            } else {
                typeSpecificData = ["":""]
            }

            let typeData : NSData = NSKeyedArchiver.archivedDataWithRootObject(typeSpecificData)
            
            
            
            returnData = ["id": id, "type": type, "title": title, "teaser": teaser, "thumbnailData": imageData!, "typeData": typeData]
        }
        
        return returnData
    }
    
//    private static func buildDataFor(type:String) -> NSData? {
//        
//        var returnedData:NSData? = nil
//    
//        if type == "Movie" {
//            returnedData =
//        } else if type == "Movie" {
//        
//        }
//        
//        var dictionaryExample : [String:AnyObject] = ["user":"UserName", "pass":"password", "token":"0123456789", "image":0] // image should be either NSData or empty
//        let dataExample : NSData = NSKeyedArchiver.archivedDataWithRootObject(dictionaryExample)
        //let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(dataExample)! as! NSDictionary
//
//        print(dictionary)
//        
//        
//        return returnedData
//    }

}