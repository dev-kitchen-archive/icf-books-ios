//
//  DetailTableViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 24.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData
import AVKit
import AVFoundation

enum MediaType {
    case Title, Description, Movie, Image
}

class DetailTableViewController: UITableViewController {
    
    var scan: NSManagedObject?
    var tableData = [[MediaType: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add a blurry layer for background image
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        view.insertSubview(blurView, atIndex: 0)
        // TODO: add constrints to blur view
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: blurView, attribute: .Top, multiplier: 1.0, constant: 0.0))
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: blurView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: blurView, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
//        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: blurView, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        
        //makes the cell as high as it needs to be, regarding the content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        if scan != nil {
            if let detailTitle = scan!.valueForKey("title") as? String {
                if detailTitle != "" {
                    tableData.append([MediaType.Title: detailTitle])
                }
            }
            if scan!.valueForKey("thumbnail_data") as? NSData != nil {
                let movieThumbData = scan!.valueForKey("thumbnail_data") as? NSData
                let movieThumb = movieThumbData.map({UIImage(data: $0)})!
                tableData.append([MediaType.Movie: movieThumb!])
                
                defineTableBackground(movieThumb!)
            }
            if let detailDesc = scan!.valueForKey("teaser") as? String {
                if detailDesc != "" {
                    tableData.append([MediaType.Description: detailDesc])
                }
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func defineTableBackground(img: UIImage){
        let imageView = UIImageView(image: img)
        imageView.contentMode = .Top
        tableView.backgroundView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count * 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = tableData[(indexPath.row % tableData.count)]
        let mediaType = data.keys.first
        
        if mediaType == MediaType.Title {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailTitleCell", forIndexPath: indexPath) as? DetailTitleCell
            cell!.detailTitle.text = data[mediaType!] as? String
            cell!.backgroundColor = .clearColor()
            
            return cell!
            
        } else if mediaType == MediaType.Movie {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailMovieCell", forIndexPath: indexPath) as? DetailMovieCell
            cell!.detailMovieThumb.image = data[mediaType!] as? UIImage
            cell!.backgroundColor = .clearColor()

            return cell!
            
        } else /*if mediaType == MediaType.Description*/ {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailDescriptionCell", forIndexPath: indexPath) as? DetailDescriptionCell
            cell!.detailDescription.text = data[mediaType!] as? String
            cell!.backgroundColor = .clearColor()
            
            return cell!
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo" {
            let urlStr = (Api.baseUrl as String) + (scan!.valueForKey("file_url") as! String)
            print(urlStr)
            //let url = NSURL(string: urlStr)
            let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            
            let destination = segue.destinationViewController as! AVPlayerViewController
            destination.player = AVPlayer(URL: url!)
            
        }
    }

}
