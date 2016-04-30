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
            let mediaTypeDict = dict.objectForKey("data") as! NSDictionary
            //do a lot of good validation somewhere
            //do a lot of good validation somewhere
            //do a lot of good validation somewhere
            //do a lot of good validation somewhere
            //do a lot of good validation somewhere
            var mediaTypeData:MediaTypeData?
            if let validType = MediaType.getFrom(string: type) {
                mediaTypeData = MediaTypeData(type: validType, jsonDict: mediaTypeDict)
            }
            
            let typeData : NSData = NSKeyedArchiver.archivedDataWithRootObject(mediaTypeData!)
            
            returnData = ["id": id, "type": type, "title": title, "teaser": teaser, "thumbnailData": imageData!, "typeData": typeData]
        }
        
        return returnData
    }
    
    // TODO: do all this in MediaTypeData:
    //            var typeSpecificData:[String:AnyObject]
    //            if type == "movie" {
    //                //some of the data is redundant on purpose, as the data above is needed
    //                //as meta data (for cell title etc) and the following data is needed for the
    //                //detail view
    //                let fileUrl = mediaTypeDict.objectForKey("file_url") as! String
    //                typeSpecificData = ["title":title, "description":teaser, "thumbnail":imageData!, "video_url":fileUrl]
    //            } else if type == "two_movies_and_text" {
    //
    //                let dataMove1 = mediaTypeDict.objectForKey("movie1_url") as! String
    //                let dataMove2 = mediaTypeDic.objectForKey("movie2_url") as! String
    //                let dataDesc1 = mediaTypeData.objectForKey("description1") as! String
    //                let dataDesc2 = mediaTypeData.objectForKey("description2") as! String
    //
    //                typeSpecificData = ["title":title, "description1":dataDesc1, "description2":dataDesc2, "thumbnail":imageData!, "video_url1":dataMove1, "video_url2":dataMove2]
    //            } else {
    //                typeSpecificData = ["":""]
    //            }
    //
    //            let typeData : NSData = NSKeyedArchiver.archivedDataWithRootObject(typeSpecificData)
    

}