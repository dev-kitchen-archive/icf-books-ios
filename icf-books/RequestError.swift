//
//  RequestError.swift
//  icf-books
//
//  Created by Andreas Plüss on 05.05.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

enum RequestError: String {
    case
    ParsingError = "parsingError",
    
    UnexpectedServerBehaving = "unexpected server side bahing",
    BadUrl = "compund url is corrupted",
    InvalidData = "the data that should be sent is not valid",
    Error401 = "not authorized",
    Error404 = "uri path not found",
    Error500 = "internal server error",
    Error204 = "empty content"
}
