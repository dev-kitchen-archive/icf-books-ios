//
//  ButtonPressProtocol.swift
//  interactive book
//
//  Created by Andreas Plüss on 20.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import Foundation

protocol ButtonPressProtocol : NSObjectProtocol {
    func actionOnPress(message: String) -> Void
}