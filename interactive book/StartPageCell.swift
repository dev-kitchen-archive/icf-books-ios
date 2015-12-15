//
//  StartPageCell.swift
//  interactive book
//
//  Created by Andreas Plüss on 15.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class StartPageCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
