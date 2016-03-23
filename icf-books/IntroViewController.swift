//
//  IntroViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 23.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class IntroViewController: MasterViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pages =  [("Title 1", "imgName1", "Desc 1"),
                    ("Title 2", "imgName2", "Desc 2"),
                    ("Title 3", "imgName3", "Desc 3"),
                    ("Title 4", "imgName4", "Desc 4")]
    var cells = [UICollectionViewCell]()
    var lastSeenCell: UICollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Color.accent
    }
    
    // the controller that has a reference to the collection view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.collectionView.contentInset
        let value = (self.view.frame.size.width - getItemSize().width) * 0.5
        insets.left = value
        insets.right = value
        self.collectionView.contentInset = insets
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        let centerPoint = CGPointMake(self.collectionView.center.x + self.collectionView.contentOffset.x, self.collectionView.center.y + self.collectionView.contentOffset.y)
        let currentIndexPath = collectionView.indexPathForItemAtPoint(centerPoint)
        if currentIndexPath!.row + 1 < cells.count {
            let nextIndexPath = collectionView.indexPathForCell(cells[currentIndexPath!.row + 1])
            if nextIndexPath != nil {
                collectionView.scrollToItemAtIndexPath(nextIndexPath!, atScrollPosition: .CenteredHorizontally, animated: true)
            } else {
                collectionView.scrollToItemAtIndexPath(collectionView.indexPathForCell(lastSeenCell!)!, atScrollPosition: .CenteredHorizontally, animated: true)
            }
            
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UICollectionViewDataSource
    // This extension allows the cell to deliver the data to its containing CollectionView cells through the delegated Functions
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pageCell", forIndexPath: indexPath)
        cells.append(cell)
        
        if cells.count > 0 {
            lastSeenCell = cells[0]
        }
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // This extension allows the cell to define the layout of its containing CollectionViews cells through the delegated Functions
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return getItemSize()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let centerPoint = CGPointMake(self.collectionView.center.x + self.collectionView.contentOffset.x, self.collectionView.center.y + self.collectionView.contentOffset.y)
        if let currentIndexPath = collectionView.indexPathForItemAtPoint(centerPoint) {
            collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        }
//        else {
//            collectionView.scrollToItemAtIndexPath(collectionView.indexPathForCell(lastSeenCell!)!, atScrollPosition: .CenteredHorizontally, animated: true)
//        }
        
    }
    
    func getItemSize() -> CGSize {
        let itemsPerRow:CGFloat = 1.2
        let hardCodedPadding:CGFloat = 20.0
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
