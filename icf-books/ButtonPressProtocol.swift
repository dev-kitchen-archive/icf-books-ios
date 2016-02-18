//
//  ButtonPressProtocol.swift
//  icf-books
//
//  Created by Andreas Plüss on 17.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation

enum OpenView {
    case Scanner
}

protocol ButtonPressProtocol : NSObjectProtocol {
    func actionOnPress(viewCtrl: OpenView) -> Void
}