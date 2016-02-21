//
//  DetailViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreData

enum GetJSONDataError: ErrorType {
    case NoInternet, EmptyData, ParsingError, NoError
}

class DetailViewController: UIViewController {
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailTeaser: UILabel!
    @IBOutlet weak var detailVideo: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var scan: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: "mediaOptions")
        
        if scan != nil {
            detailTitle.text = scan!.valueForKey("title") as? String
            detailTeaser.text = scan!.valueForKey("teaser") as? String
            
            let imgData = scan!.valueForKey("thumbnail_data") as? NSData
            videoImage.image = imgData.map({UIImage(data: $0)})!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideo" {
            let urlStr = (apiBaseUrl as String) + (scan!.valueForKey("file_url") as! String)
            print(urlStr)
            //let url = NSURL(string: urlStr)
            let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            
            let destination = segue.destinationViewController as! AVPlayerViewController
            destination.player = AVPlayer(URL: url!)
            
        }
    }
    
//    //ActionSheet for future use
//    func mediaOptions(){
//        let alertController = UIAlertController(title: nil, message: "Was möchtest Du mit diesem gescannten Eintrag machen?", preferredStyle: .ActionSheet)
//        let cancelAction = UIAlertAction(title: "Abbrechen", style: .Cancel) { (action) in
//            print("ActionSheet cancel")
//        }
//        let reloadAction = UIAlertAction(title: "Neu laden", style: .Default) { (action) in
//            print("ActionSheet reload")
//        }
//        let destroyAction = UIAlertAction(title: "Eintrag aus Übersicht entfernen", style: .Destructive) { (action) in
//            print("ActionSheet deleted")
//        }
//        alertController.addAction(cancelAction)
//        alertController.addAction(reloadAction)
//        alertController.addAction(destroyAction)
//        
//        self.presentViewController(alertController, animated: true) {
//
//        }
//    }
}
