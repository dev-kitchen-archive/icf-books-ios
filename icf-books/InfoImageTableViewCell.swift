//
//  InfoImageTableViewCell.swift
//  icf-books
//
//  Created by Andreas Plüss on 17.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class InfoImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    var infoImage: UIImage? = UIImage(named: "no_scanned_codes_de")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellImage.image = infoImage
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
