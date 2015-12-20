//
//  MultipleInfosCell
//  interactive book
//
//  Created by Andreas Plüss on 17.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

/// This Cell contains a CollectionVeiw and displays multiple objects, it is used in the HomeView
class MultipleNewsCell: UITableViewCell {
    
    var newsGroup:NewsGroup?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

// MARK: - UICollectionViewDataSource
// This extension allows the cell to deliver the data to its containing CollectionView cells through the delegated Functions
extension MultipleNewsCell : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsGroup!.news.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("infoCollectionCell", forIndexPath: indexPath) as! InfoCollectionCell
        
        cell.cellTitle.text = newsGroup!.news[indexPath.row].title
        cell.cellDescription.text = newsGroup!.news[indexPath.row].description
        cell.cellImage.image = newsGroup!.news[indexPath.row].image
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
// This extension allows the cell to define the layout of its containing CollectionViews cells through the delegated Functions
extension MultipleNewsCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 1.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
