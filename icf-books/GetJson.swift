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
    static func retrieveDictFrom(url: NSURL, completionHandler: (jsonDict: NSDictionary?, errorMessage: String?) -> ()) {
        var retrievedData: NSDictionary?
        var errorString: String? = nil

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            do {
                if data != nil {
                    retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as? NSDictionary
                    
                    if retrievedData == nil {
                        print("InvalidData")
                        errorString = "Invalid Data"
                    }
                } else {
                    print("NoInternet")
                    errorString = "No Internet"
                }
                
            } catch (let message) {
                print("ParsingError")
                errorString = "Parsing Error"
            }
            
            if retrievedData != nil && retrievedData!.valueForKey("status") as! String != "404" {
                let error = retrievedData?.valueForKey("No Data @ given URL")
            }
            
            completionHandler(jsonDict: retrievedData, errorMessage: errorString)
        }
        
        task.resume()
    }
}
