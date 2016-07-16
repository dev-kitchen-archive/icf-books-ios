//
//  HomeViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData
import BubbleTransition

class HomeViewController: MasterViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var tabBar: UIView!
    let transition = BubbleTransition()
    
    var scans = [NSManagedObject]()
    var thumbnails = [UIImage]()
    var chaptersCount = 1
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load table data
        readScannedObjects()
        
        //make scan button round
        scanButton.layer.cornerRadius = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
        
        scanButton.imageView?.contentMode = .ScaleAspectFit
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readScannedObjects(){
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //2
        let fetchRequest = NSFetchRequest(entityName: "Media")
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            scans = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        //prepare images for cells to be faster accessable
        for scan in scans {
            let imgData = scan.valueForKey("thumbnail_data") as? NSData
            let imageArray = imgData.map({UIImage(data: $0)})
            let image = imageArray!
            thumbnails.append(image!)
        }
        
        
        //make sure that table data is reloaded after successfully loading core data
        //because you could have new entries in coredata afer scanning new entry
        table.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if scans.count < 1 {
            return 1
        } else {
            return chaptersCount + 1 //if there are scanns, have a second section containing an empty cell for bottom space
        }
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return nil
//            //bookmarks could be in section == 1
//            
//        } else if section == chaptersCount + 2 - 1 {
//            return nil
//        } else {
//            return "Kapitel \(section) — Schönheit bewegt"
//        }
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scans.count < 1 || section == chaptersCount { //either about book or intro image
            //make content not scrollable
            tableView.scrollEnabled = false
            return 1
        } else { //spacing section with space for button to scan
            tableView.scrollEnabled = true
            return scans.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // if nothing is scanned yet, show info howto use (only 1 section will be given)
        if scans.count < 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("infoImageCell") as? InfoImageTableViewCell
            if cell == nil {
                cell = InfoImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "infoImageCell")
            }
        
            return cell!
            
        }
        // last section after chapters sections --> spacing cell section
        else if indexPath.section == chaptersCount {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            cell!.scanImage.image = UIImage()
            cell!.scanTitle.hidden = true
            cell!.gradient.hidden = true
            return cell!
        }
        //for all other sections (that represent each chapter) show its containig scans
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            let scan = scans[indexPath.row]
            cell!.scanImage.image = thumbnails[indexPath.row]
            cell!.scanTitle.text = scan.valueForKey("title") as? String
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let width = UIScreen.mainScreen().bounds.width
        let height = tableView.bounds.height
        if scans.count < 1 {
            return height
        } else if indexPath.section == chaptersCount {
            return 90 // equals folating scan button
        } else {
            return width
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "openSavedScan" {
            if let indexPath = table.indexPathForSelectedRow {
                if indexPath.section != chaptersCount + 1 {
                    let destinationVC = segue.destinationViewController as! DetailTableViewController
                    destinationVC.scan = scans[indexPath.row]
                }
            }
        } else if segue.identifier == "openScanner" {
            let controller = segue.destinationViewController as! ScannerViewController
            controller.homeDelegate = self
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if let ident = identifier {
            if ident == "openSavedScan" {
                if let indexPath = table.indexPathForSelectedRow {
                    if indexPath.section == chaptersCount + 1 {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = tabBar.center
        transition.duration = 0.38
        transition.bubbleColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = tabBar.center
        transition.duration = 0.38
        transition.bubbleColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        return transition
    }
    
}

