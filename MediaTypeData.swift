//
//  MediaTypeData.swift
//  icf-books
//
//  Created by Andreas Plüss on 31.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

enum MediaType:String {
    case Movie = "movie", TwoMovies = "two_movies_and_text"
    
    static func getFrom(string str:String) -> MediaType? {
        if let type = MediaType(rawValue: str) {
            return type
        } else {
            return nil
        }
    }
}

class MediaTypeData {
    var type:MediaType
    var data:[String:AnyObject]?
    
    init(type:MediaType, jsonDict:NSDictionary){
        self.type = type
        self.parseFromJson(jsonDict)
    }
    
    func parseFromJson(dict:NSDictionary) {
        
        switch type {
        case .Movie:
            let fileUrl = dict.objectForKey("file_url") as! String
            
            data = ["title":"Ester", "description":"Sie kam als arme Frau", "thumbnail":"", "video_url":fileUrl]
            
        case .TwoMovies:
            let dataMove1 = dict.objectForKey("movie1_url") as! String
            let dataMove2 = dict.objectForKey("movie2_url") as! String
            let dataDesc1 = dict.objectForKey("description1") as! String
            let dataDesc2 = dict.objectForKey("description2") as! String

            data = ["title":"Ester und Gott", "description1":dataDesc1, "description2":dataDesc2, "thumbnail":"", "video_url1":dataMove1, "video_url2":dataMove2]
        }
    }
}