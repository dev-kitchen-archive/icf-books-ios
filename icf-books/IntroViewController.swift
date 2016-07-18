//
//  IntroViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 23.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class IntroViewController: MasterViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data = [[NSLocalizedString("INTRO_1_TITLE", comment:"Welcome Title"),
        NSLocalizedString("INTRO_1_IMAGE", comment:"Welcome image"),
        NSLocalizedString("INTRO_1_DESCRIPTION", comment:"Welcome description"),
        NSLocalizedString("INTRO_1_BUTTON", comment:"nope")]]
    
    var cells = [IntroSliderCell]()
    var lastCell:UICollectionViewCell?
    var currentPosition = 0 {
        didSet { positionChangedListener() }
    }
    var createdOnce = false

    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.setTitle(NSLocalizedString("INTRO_1_BUTTON", comment:"nope"), forState: .Normal)
            
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
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
        //scrolling to next cell on the right by Cell
        //of close modal if you are on last page
        if currentPosition + 1 < cells.count {
            defineCenterCell(asNextCellOnTheRight: true)
        } else {
            //let application know, that the user as seen the intro
            userDefaults.setValue(true, forKey: "appAlreadyUsed")
            userDefaults.synchronize()
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func positionChangedListener() {
        if currentPosition + 1 == data.count {
            nextButton.setTitle(NSLocalizedString("BUTTON_START", comment:"Button that closes slides"), forState: .Normal)
        } else {
            nextButton.setTitle(NSLocalizedString("BUTTON_NEXT", comment:"Button to next page"), forState: .Normal)
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
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(!createdOnce) {
            for i in 0..<data.count {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pageCell", forIndexPath: NSIndexPath(forRow: i, inSection: 0)) as! IntroSliderCell
                cell.cellTitle.text = data[i][0]
                cell.cellImage.image = UIImage(named: data[i][1])
                cell.cellDescription.text = data[i][2]
                cells.append(cell)
                
                if i == 0 {
                    lastCell = cell
                }
            }
            
            createdOnce = true
        }
        
        return cells[indexPath.row]
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // This extension allows the cell to define the layout of its containing CollectionViews cells through the delegated Functions
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return getItemSize()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        defineCenterCell()
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        defineCenterCell()
    }
    
    func defineCenterCell(asNextCellOnTheRight nextCell:Bool = false) {
        if !nextCell {
            
            //scrolling to the center of the current cell by indexPath
            let centerPoint = CGPointMake(self.collectionView.center.x + self.collectionView.contentOffset.x, self.collectionView.center.y + self.collectionView.contentOffset.y)
            let leftPoint = CGPointMake(0, self.collectionView.center.y + self.collectionView.contentOffset.y)
            if let currentIndexPath = collectionView.indexPathForItemAtPoint(centerPoint) {
                setCurrentCell(collectionView.cellForItemAtIndexPath(currentIndexPath)!)
                collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            } else if let leftIndexPath = collectionView.indexPathForItemAtPoint(leftPoint) {
                collectionView.indexPathForCell(lastCell!)
                collectionView.scrollToItemAtIndexPath(leftIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            }
        } else {
            
            //scrolling to next cell on the right by Cell
            //of close modal if you are on last page
            if currentPosition + 1 < cells.count {
                if let nextCellIndexPath = collectionView.indexPathForCell(cells[currentPosition + 1]) {
                    collectionView.scrollToItemAtIndexPath(nextCellIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
                    setCurrentCell(collectionView.cellForItemAtIndexPath(nextCellIndexPath)!)
                }
            }
        }
    }
    
    func setCurrentCell(cell:UICollectionViewCell) {
        let cl = cell as! IntroSliderCell
        if let i = cells.indexOf(cl) {
            currentPosition = i
        }
        
        //might be needed as fallback cell for new swipe that could fail if no new cell is found
        lastCell = cell
    }
    
    func getItemSize() -> CGSize {
        let itemsPerRow:CGFloat = 1.2
        let hardCodedPadding:CGFloat = 20.0
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
