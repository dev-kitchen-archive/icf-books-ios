//
//  HorizontalCell.swift
//  interactive book
//
//  Created by Andreas Plüss on 17.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class HorizontalCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var cellDescriptions = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*UICollectionViewDataSource*/
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    /*UICollectionViewDataSource*/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("infoCell", forIndexPath: indexPath)
        
        //TODO:
        //set the margin left for the firs element to be 1/4 of a card so it is in the center
        //as example one cell manipulated:
        if indexPath.row == 1 {
            cell.layer.borderColor = UIColor.blueColor().CGColor
            cell.layer.borderWidth = 2
        }
        
        return cell
    }
    
    /*UICollectionViewDelegateFlowLayout*/
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 1.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
