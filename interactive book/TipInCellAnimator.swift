//
//  TipInCellAnimator.swift
//  interactive book
//
//  Created by Andreas Plüss on 20.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit
import QuartzCore

class TipInCellAnimator {
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        let rotationDegrees: CGFloat = -8.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(M_PI)/180.0)
        let offset = CGPointMake(100, 100)
        var startTransform = CATransform3DIdentity // 2
        startTransform = CATransform3DRotate(CATransform3DIdentity,
            rotationRadians, 0.0, 0.0, 1.0) // 3
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0) // 4
        
        // 5
        view.layer.transform = startTransform
        view.layer.opacity = 0.4
        
        // 6
        UIView.animateWithDuration(0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}