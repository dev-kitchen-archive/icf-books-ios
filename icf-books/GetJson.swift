//
//  GetJson.swift
//  icf-books
//
//  Created by Andreas Plüss on 18.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

/// This class is responsible to retrieve JSON formated text from a server and enables you to then get the data as Dictionary
class GetJson {
    /**
     Requests data from the instances defined URL.
     - parameter completionHandler: is a function responsible to proceed with the retrieved data.
     */
    static func retrieveDictFrom(url: NSURL, completionHandler: (jsonDict: NSDictionary, error: GetJSONDataError?) -> ()) {
        var retrievedData: NSDictionary?
        var jsonError: GetJSONDataError?

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            do {
                if data != nil {
                    retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as? NSDictionary
                    
                    if retrievedData == nil {
                        print("InvalidData")
                        jsonError = GetJSONDataError.EmptyData
                    }
                } else {
                    print("NoInternet")
                    jsonError = GetJSONDataError.NoInternet
                }
                
            } catch (let message) {
                print("ParsingError")
                jsonError = GetJSONDataError.ParsingError
            }
            
            if retrievedData == nil {
                retrievedData = NSDictionary()
            }
            completionHandler(jsonDict: retrievedData!, error: jsonError)
        }
        
        task.resume()
    }
}
