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
    var data =  [["WILLKOMMEN", "intro_welcome", "Erweitere dein Buch mit Zusatzinfos, Bildern und Videos."],
                 ["SO GEHTS", "intro_scan", "Scanne die QR-Codes im Buch um die Inhalte anzuzeigen."],
                 ["WIEDERFINDEN", "intro_find", "Einmal gescannte Inhalte kannst du jederzeit wieder anzeigen."],
                 ["WIEDERFINDEN", "intro_find", "Einmal gescannte Inhalte kannst du jederzeit wieder anzeigen."]]
    var cells = [IntroSliderCell]()
    var currentPosition = 0
    var createdOnce = false

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
        //scrolling to next cell on the right by Cell
        //of close modal if you are on last page
        if currentPosition + 1 < cells.count {
            defineCenterCell(asNextCellOnTheRight: true)
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
                print("found center cell: ");print(collectionView.cellForItemAtIndexPath(currentIndexPath))
                setCurrentCell(collectionView.cellForItemAtIndexPath(currentIndexPath)!)
                collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            } else if let leftIndexPath = collectionView.indexPathForItemAtPoint(leftPoint) {
                print("found left cell: ");print(collectionView.cellForItemAtIndexPath(leftIndexPath))
                setCurrentCell(collectionView.cellForItemAtIndexPath(leftIndexPath)!)
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
            print("cell position \(i) of \(cells.count)")
        } else {
            print("cell not in created array")
        }
    }
    
    func getItemSize() -> CGSize {
        let itemsPerRow:CGFloat = 1.2
        let hardCodedPadding:CGFloat = 20.0
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
