//
//  IntroSliderCell.swift
//  icf-books
//
//  Created by Andreas Plüss on 23.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class IntroSliderCell: UICollectionViewCell {
    @IBOutlet weak var wrapper: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //designing the cell
        wrapper.layer.borderColor = Color.accent.CGColor
        wrapper.layer.borderWidth = 0.5
        
        wrapper.layer.shadowColor = UIColor.blackColor().CGColor
        wrapper.layer.shadowOffset = CGSize(width: 0, height: 1)
        wrapper.layer.shadowOpacity = 0.2
        wrapper.layer.shadowRadius = 1.2
    }
}
