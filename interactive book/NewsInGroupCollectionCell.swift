//
//  InfoCollectionCell.swift
//  interactive book
//
//  Created by Andreas Plüss on 18.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

/// this CollectionView Cell is displayed in the MultipleInfosCell on the HomeView
class NewsInGroupCollectionCell: UICollectionViewCell {
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    weak var delegate:ButtonPressProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //designing the cell
        content.layer.borderColor = UIColor(red:1, green:0.58, blue:0.01, alpha:1).CGColor
        content.layer.borderWidth = 0.5
        
        shadow.layer.shadowColor = UIColor.blackColor().CGColor
        shadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadow.layer.shadowOpacity = 0.2
        shadow.layer.shadowRadius = 1.2
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var message = "Nachricht aus der News Group "
        if cellTitle != nil {
            message += "\"" + cellTitle.text! + "\""
        }
        if((delegate?.respondsToSelector("actionOnPress:")) != nil) {
            delegate?.actionOnPress((ActionType.Alert, message))
        }
    }
}
