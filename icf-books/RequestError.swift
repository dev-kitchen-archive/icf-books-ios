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
    InvalidData = "invalidData",
    NoData = "noData",
    NoInternet = "noInternet",
    Error401 = "error401",
    Error404 = "error404",
    Error500 = "error500",
    EmptyData = "emptyData",
    ParsingError = "parsingError",
    BadUrl = "badUrl"
}
