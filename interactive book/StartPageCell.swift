//
//  StartPageCell.swift
//  interactive book
//
//  Created by Andreas Plüss on 15.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class StartPageCell: UITableViewCell {
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellTitle.font = UIFont(descriptor: UIFontDescriptor(name: "AmericanTypewriter", size: 18), size: 18)
        cellTitle.textColor = UIColor(red:1, green:0.4, blue:0.38, alpha:1)
        
        contentContainerView.layer.borderWidth = 0.5
        contentContainerView.layer.borderColor = UIColor(red:1, green:0.4, blue:0.38, alpha:1).CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }

}
