//
//  HomeViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: MasterViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!

    var scans = [NSManagedObject]()
    var chaptersCount = 1
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load table data
        readScannedObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
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
        
        //make sure that table data is reloaded after successfully loading core data
        //because you could have new entries in coredata afer scanning new entry
        table.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if scans.count < 1 {
            return 1
        } else {
            return chaptersCount + 2 //plus two for firs section containing progress and las one that has spacing cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
            //bookmarks could be in section == 1
            
        } else if section == chaptersCount + 2 - 1 {
            return nil
        } else {
            return "Kapitel \(section)"
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { //either about book or intro image
            return 1
        } else if section == chaptersCount + 1 { //spacing section sith space for button to scan
            return 1
        } else { //actual scans for chapter
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
            
            //make content not scrollable
            tableView.scrollEnabled = false
        
            return cell!
            
        }
        // if something is scanned show progress in 1st section (only 1 cell given)
        else if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("progressCell") as? ProgressTableViewCell
            if cell == nil {
                cell = ProgressTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "progressCell")
            }
            
            //cell!.titel oder so

            return cell!
            
        }
        // last section after chapters (1 spacing cell)
        else if indexPath.section == chaptersCount + 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            cell!.scanTitle.text = ""
            cell!.scanDesc.text = ""
            cell!.scanImage.image = UIImage()
            return cell!
        }
        //for all other sections (that represent each chapter) show its containig scans
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            let scan = scans[indexPath.row]
            
            let imgData = scan.valueForKey("thumbnail_data") as? NSData
            let imageArray = imgData.map({UIImage(data: $0)})
            cell!.scanImage.image = imageArray!
            
            cell!.scanTitle.text = scan.valueForKey("title") as? String
            cell!.scanDesc.text = scan.valueForKey("teaser") as? String
            //cell!.titel oder so
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if scans.count < 1 {
            return 600
        } else if indexPath.section == 0 {
            return 90
        } else if indexPath.section == chaptersCount + 1 {
            return 75 // equals folating scan button
        } else {
            return 120
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "openSavedScan" {
            if let indexPath = table.indexPathForSelectedRow {
//                let destinationVC = segue.destinationViewController as! DetailViewController
//                destinationVC.scan = scans[indexPath.row]
                
                let destinationVC = segue.destinationViewController as! DetailTableViewController
                destinationVC.scan = scans[indexPath.row]
            }
        } else if segue.identifier == "openScanner" {
            let destinationVC = segue.destinationViewController as! ScannerViewController
            destinationVC.homeDelegate = self
        }
    }
    
}

