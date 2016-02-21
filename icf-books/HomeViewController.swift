//
//  HomeViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!

    var scans = [NSManagedObject]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scans.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if scans.count < 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("infoImageCell") as? InfoImageTableViewCell
            if cell == nil {
                cell = InfoImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "infoImageCell")
            }
            
            //cell!.titel oder so
        
            return cell!
            
        } else if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("progressCell") as? ProgressTableViewCell
            if cell == nil {
                cell = ProgressTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "progressCell")
            }
            
            //cell!.titel oder so

            return cell!
            
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            let scan = scans[indexPath.row - 1]
            
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
        } else if indexPath.row == 0 {
            return 90
        } else {
            return 120
        }
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "openSavedScan" {
            if let indexPath = table.indexPathForSelectedRow {
                let destinationVC = segue.destinationViewController as! DetailViewController
                destinationVC.scan = scans[indexPath.row - 1]
            }
        }
    }



    
    func readScannedObjects(){
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        //2
        let fetchRequest = NSFetchRequest(entityName: "Media")
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            scans = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
}

