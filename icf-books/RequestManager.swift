//
//  RequestManager.swift
//  icf-books
//
//  Created by Andreas Plüss on 05.05.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

class RequestManager {
    
    static private let uri = Api.getLanguageUrl()

    ///TODO: depercated
//    // get all books
//    static func getBooks(completionHandler: (books:NSArray?, error:RequestError?) -> (Void)) {
//        
//        //get specific request
//        if let request = httpGetOn("/books") {
//            
//            //get data
//            getDataFromRequest(request, retrieveArray: true, callback: {retrievedData, errorMessage -> Void in
//                var books:NSArray? = nil
//                var error:RequestError? = nil
//                
//                //if no error, bring the data in needed shape
//                if errorMessage == nil {
//                    if let rawData = retrievedData as? NSArray {
//                        books = rawData
//                    } else {
//                        error = RequestError.ParsingError
//                    }
//                    //Parsing
//                    //let info = retrievedData!["Info"] as! NSDictionary
//                    //let listExists = Int((info.valueForKey("NumOutRows") as? String)!)! > 0
//                    //
//                    //if listExists {
//                    //    books = retrievedData!["List"] as! NSDictionary
//                    //}
//                }
//                completionHandler(books: books, error: error)
//            })
//        } else {
//            completionHandler(books: nil, error: RequestError.BadUrl)
//        }
//    }

    ///TODO: postponed
//    // get chapters for a specific book
//    static func getBookChapters(id:Int, completionHandler: (chapters:NSArray?, error:RequestError?) -> (Void)) {
//        
//        //get specific request
//        if let request = httpGetOn("/books", params: "/\(id)/chapters") {
//            
//            //get data
//            getDataFromRequest(request, retrieveArray: true, callback: {retrievedData, errorMessage -> Void in
//                var chapters:NSArray? = nil
//                var error:RequestError? = nil
//                
//                //if no error, bring the data in needed shape
//                if errorMessage == nil {
//                    if let rawData = retrievedData as? NSArray {
//                        chapters = rawData
//                    } else {
//                        error = RequestError.ParsingError
//                    }
//                    //Parsing
//                    //let info = retrievedData!["Info"] as! NSDictionary
//                    //let listExists = Int((info.valueForKey("NumOutRows") as? String)!)! > 0
//                    //
//                    //if listExists {
//                    //    books = retrievedData!["List"] as! NSDictionary
//                    //}
//                }
//                completionHandler(chapters: chapters, error: error)
//            })
//        } else {
//            completionHandler(chapters: nil, error: RequestError.BadUrl)
//        }
//    }
    
    //TODO: error handling complete?
    // get media for an id
    static func getMedia(forMediaId id:String, changedSince:String = "", completionHandler: (media:NSDictionary?, error:RequestError?) -> (Void)) {
        
        //get specific request
        if let request = httpGetOn("/media", params: "/\(id)") {
            //get data
            getDataFromRequest(request, callback: {retrievedData, errorMessage -> Void in
                var media:NSDictionary? = nil
                var error:RequestError? = errorMessage
                
                //if no error, bring the data in needed shape
                if errorMessage == nil {
                    if let rawData = retrievedData as? NSDictionary {
                        media = rawData
                    } else {
                        error = RequestError.ParsingError
                    }
                }
                completionHandler(media: media, error: error)
            })
        } else {
            completionHandler(media: nil, error: RequestError.BadUrl)
        }
    }
    
    
    //all errors handled correctly
    static func postNewsletter(email:String, name:String, completionHandler: (error:RequestError?) -> (Void)) {
        
        let data = ["email":email, "name":name, "source":"ios"]
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted)
            
            //get specific request
            if let request = httpPostOn("/newsletter_subscriptions", data: jsonData) {
                ///bububu
                getDataFromRequest(request, callback: {retrievedData, errorMessage -> Void in
                    if errorMessage == RequestError.Error204 {
                        //http status 204 is successful answer of server
                        completionHandler(error: nil)
                    } else {
                        completionHandler(error: RequestError.UnexpectedServerBehaving)
                    }
                })
                
            } else {
                completionHandler(error: RequestError.BadUrl)
            }
        } catch {
            completionHandler(error: RequestError.InvalidData)
        }
    }
    
    // generic helpers
    // helper for HTTP GET requests
    private static func httpGetOn(path:String, params:String = "") -> NSMutableURLRequest? {
        
        let friendlyUrl = uri + path + params + ".json"
        
        if let requestUrl = NSURL(string: friendlyUrl) {
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: requestUrl)
            request.HTTPMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return request
        } else {
            return nil
        }
    }
    
    // helper for HTTP POST requests
    private static func httpPostOn(path:String, data:NSData) -> NSMutableURLRequest? {
        
        let friendlyUrl = uri + path
        
        if let requestUrl = NSURL(string: friendlyUrl) {
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: requestUrl)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = data
            
            return request
        } else {
            return nil
        }
    }
    
    // genericly retrieve data depending on the request (for token, patients and tasks)
    private static func getDataFromRequest(request: NSMutableURLRequest, retrieveArray:Bool = false, callback: (retrievedData:AnyObject?, errorMessage:RequestError?) -> (Void)) {
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var retrievedData: AnyObject? = nil
            var errorMsg: RequestError? = nil
            
            //try to get data
            do {
                if data != nil {
                    if retrieveArray {
                        retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSArray
                    } else {
                        retrievedData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                    }
                } else {
                    errorMsg = RequestError.UnexpectedServerBehaving
                    print("server timeout or wrong http header")
                    print(error)
                }
            } catch {
                errorMsg = RequestError.InvalidData
            }
            
            //errors depending on status codes 
            if let statusCode = (response as? NSHTTPURLResponse)?.statusCode {
                if statusCode == 401 {
                    errorMsg = RequestError.Error401
                } else if statusCode == 404 {
                    errorMsg = RequestError.Error404
                } else if statusCode == 500 {
                    errorMsg = RequestError.Error500
                } else if statusCode == 204 {
                    errorMsg = RequestError.Error204
                }
            } else {
                errorMsg = RequestError.UnexpectedServerBehaving
            }
            
            callback(retrievedData: retrievedData, errorMessage: errorMsg)
        })
        
        task.resume()
    }
}
