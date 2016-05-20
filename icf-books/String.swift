//
//  String.swift
//  icf-books
//
//  Created by Andreas Plüss on 20.05.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

extension String {
    // new functionality to add to SomeType goes here
    
    func removeHttp() -> String {
        return self.stringByReplacingOccurrencesOfString("http", withString: "").stringByReplacingOccurrencesOfString("https", withString: "")
    }
}