//
//  NewsCell
//  interactive book
//
//  Created by Andreas Plüss on 15.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

/// This Cell displays a single object, it is used in the HomeView
class NewsCell: UITableViewCell {
    
    weak var delegate: ButtonPressProtocol?
    
    @IBOutlet weak var contentShadow: UIView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellTitle.font = UIFont(descriptor: UIFontDescriptor(name: "AmericanTypewriter", size: 18), size: 18)
        cellTitle.textColor = UIColor(red:1, green:0.4, blue:0.38, alpha:1)
        
        contentContainer.layer.borderWidth = 0.5
        contentContainer.layer.borderColor = UIColor(red:1, green:0.4, blue:0.38, alpha:1).CGColor
        
        contentShadow.layer.shadowColor = UIColor.blackColor().CGColor
        contentShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentShadow.layer.shadowOpacity = 0.2
        contentShadow.layer.shadowRadius = 1.2
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func plusPressed(sender: AnyObject) {
        let message = "You pressed the Cell: " + cellDescription.text!;
        if((delegate?.respondsToSelector("actionOnPress:")) != nil) {
            delegate?.actionOnPress(message)
        }
    }
}