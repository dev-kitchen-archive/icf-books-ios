//
//  ProgressTableViewCell.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class AboutBookCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookRelease: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var bookContainer: UIView!
    @IBOutlet weak var bookShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //container
        bookContainer.layer.borderWidth = 0.5
        bookContainer.layer.borderColor = UIColor.lightGrayColor().CGColor
        bookContainer.layer.cornerRadius = 5
        bookContainer.clipsToBounds = true
        
        bookShadow.layer.shadowColor = UIColor.blackColor().CGColor
        bookShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        bookShadow.layer.shadowOpacity = 0.2
        bookShadow.layer.shadowRadius = 2.4
        
        //button
        bookButton.layer.cornerRadius = 5
        bookButton.layer.borderWidth = 1
        bookButton.layer.borderColor = UIColor.blackColor().CGColor
        
        //strings
        bookTitle.text = NSLocalizedString("BOOK_TITLE", comment:"Ester")
        bookRelease.text = NSLocalizedString("BOOK_RELEASE", comment:"Book Release")
        bookButton.setTitle(NSLocalizedString("BOOK_BUTTON", comment:"buy"), forState: .Normal)
        
        
        //make it work on lower resolution
        if UIDevice.currentDevice().smallDevice {
            bookRelease.hidden = true
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
