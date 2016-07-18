//
//  InfoImageTableViewCell.swift
//  icf-books
//
//  Created by Andreas Plüss on 17.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class InfoImageCell: UITableViewCell {
    @IBOutlet weak var infoImageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //make it work on lower resolution
        if UIDevice.currentDevice().smallDevice {
            infoImageHeightConstraint.constant = 90
        }
        
        //strings
        infoTitle.text = NSLocalizedString("INFO_TITLE", comment:"No Videos")
        infoDescription.text = NSLocalizedString("TNFO_DESC", comment:"Click on Plus Button")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
