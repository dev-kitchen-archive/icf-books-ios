//
//  InfoCollectionCell.swift
//  interactive book
//
//  Created by Andreas Plüss on 18.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class InfoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        content.layer.borderColor = UIColor(red:1, green:0.58, blue:0.01, alpha:1).CGColor
        content.layer.borderWidth = 0.5
        
        shadow.layer.shadowColor = UIColor.blackColor().CGColor
        shadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadow.layer.shadowOpacity = 0.2
        shadow.layer.shadowRadius = 1.2
    }
    
}
