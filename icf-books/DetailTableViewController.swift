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

enum MediaCellType {
    case Title, Description, Movie, Image
}

class DetailTableViewController: UITableViewController {
    
    var scan: NSManagedObject?
    var tableData = [[MediaCellType: AnyObject]]()
    var movieUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //makes the cell as high as it needs to be, regarding the content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        //check internet connection
        if !Reachability.isConnectedToNetwork() {
            ErrorManager.internetPermission(self)
        }
        
        if scan != nil {
            
            if scan!.valueForKey("type") as! String == "movie" {
                
                let data = scan!.valueForKey("type_data") as! NSData
                let dataDict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
                
                //define title
                if let detailTitle = scan!.valueForKey("title") as? String {
                    if detailTitle != "" {
                        self.title = detailTitle
                    }
                }
                
                //define movie Cell data
                if scan!.valueForKey("thumbnail_data") as? NSData != nil {
                    let movieThumbData = scan!.valueForKey("thumbnail_data") as? NSData
                    let movieThumb = movieThumbData.map({UIImage(data: $0)})!
                    
                    movieUrl = dataDict.valueForKey("file_url") as? String
                    
                    tableData.append([MediaCellType.Movie: movieThumb!])
                }
                
                //define description Cell data
                if let detailDesc = scan!.valueForKey("teaser") as? String {
                    if detailDesc != "" {
                        tableData.append([MediaCellType.Description: detailDesc])
                    }
                }
                
                
            } else if scan!.valueForKey("type") as! String == "two_movies_and_text" {
                
                let data = scan!.valueForKey("type_data") as! NSData
                let dataDict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
                
                //define title
                if let detailTitle = scan!.valueForKey("title") as? String {
                    if detailTitle != "" {
                        self.title = detailTitle
                    }
                }
                
                //define movie 1 Cell data
                if scan!.valueForKey("thumbnail_data") as? NSData != nil {
                    let movieThumbData = scan!.valueForKey("thumbnail_data") as? NSData
                    let movieThumb = movieThumbData.map({UIImage(data: $0)})!
                    tableData.append([MediaCellType.Movie: movieThumb!])
                    
                    movieUrl = dataDict.valueForKey("movie1_url") as? String
                    
                    tableData.append([MediaCellType.Movie: movieThumb!])
                }
                
                //define description 1 Cell data
                if let detailDesc = dataDict.valueForKey("description1") as? String {
                    if detailDesc != "" {
                        tableData.append([MediaCellType.Description: detailDesc])
                    }
                }
                
                //define movie 2 Cell data
                if scan!.valueForKey("thumbnail_data") as? NSData != nil {
                    let movieThumbData = scan!.valueForKey("thumbnail_data") as? NSData
                    let movieThumb = movieThumbData.map({UIImage(data: $0)})!
                    
                    movieUrl = dataDict.valueForKey("movie2_url") as? String
                    
                    tableData.append([MediaCellType.Movie: movieThumb!])
                }
                
                //define description 2 Cell data
                if let detailDesc = dataDict.valueForKey("description2") as? String {
                    if detailDesc != "" {
                        tableData.append([MediaCellType.Description: detailDesc])
                    }
                }
                
                
            }
        }
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
        return tableData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = tableData[(indexPath.row % tableData.count)]
        let mediaType = data.keys.first
        
        if mediaType == MediaCellType.Title {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailTitleCell", forIndexPath: indexPath) as? DetailTitleCell
            cell!.detailTitle.text = data[mediaType!] as? String
            cell!.backgroundColor = .clearColor()
            
            return cell!
            
        } else if mediaType == MediaCellType.Movie {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailMovieCell", forIndexPath: indexPath) as? DetailMovieCell
            cell!.detailMovieThumb.image = data[mediaType!] as? UIImage
            cell!.backgroundColor = .clearColor()

            return cell!
            
        } else if mediaType == MediaCellType.Description {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailDescriptionCell", forIndexPath: indexPath) as? DetailDescriptionCell
            cell!.detailDescription.text = data[mediaType!] as? String
            cell!.backgroundColor = .clearColor()
            
            return cell!
        } else {
            return UITableViewCell()
        }
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        if cell is DetailMovieCell {
//            let targetController = self.storyboard!.instantiateViewControllerWithIdentifier("videoView") as! AVPlayerViewController
//            if let url = NSURL(string: movieUrl!) {
//                targetController.player = AVPlayer(URL: url)
//                self.navigationController!.pushViewController(targetController, animated: true)
//            } else {
//                ErrorManager.badUrl(self)
//            }
//            
//        }
//    }
    
    // MARK: - Navigation

    
    //TODO: depercated - remove this function
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo" {
            //let urlStr = (Api.baseUrl as String) + (scan!.valueForKey("file_url") as! String)
            //-> file url from now on in type_data
            
            //let url = NSURL(string: urlStr)
            if (movieUrl != nil) {
                if let url = NSURL(string: movieUrl!) {
                    let destination = segue.destinationViewController as! AVPlayerViewController
                    destination.player = AVPlayer(URL: url)
                } else {
                    ErrorManager.badUrl(self)
                }
            } else {
                ErrorManager.badUrl(self)
            }
            
            
        }
    }

}
