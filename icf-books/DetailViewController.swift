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
    @IBOutlet weak var videoPlaceholder: UIView!
    
    var scan: NSManagedObject?
    var row: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: "mediaOptions")
        
        if scan != nil {
            detailTitle.text = scan!.valueForKey("title") as? String
            detailTeaser.text = scan!.valueForKey("teaser") as? String
            detailVideo.text = String(row!)
        }
        
//        let urlString = scan?.valueForKey("file_url") as? String
//        let url: NSURL = NSURL(string: "http://download.wavetlan.com/SVV/Media/HTTP/H264/Talkinghead_Media/H264_test1_Talkinghead_mp4_480x360.mp4")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "playVideo" {
            let destination = segue.destinationViewController as! AVPlayerViewController
            //let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            let url = NSURL(string: "https://rhino.dev.kitchen/asset/W1siZiIsIjIwMTYvMDIvMTgvNWg0Nnk0NTBqZF9JQ0ZfV29yc2hpcF9UYWdfdW5kX05hY2h0Lm1wNCJdXQ?sha=42900332f05ca2f3")
            destination.player = AVPlayer(URL: url!)
        }
    }
    
    func mediaOptions(){
        let alertController = UIAlertController(title: nil, message: "Was möchtest Du mit diesem gescannten Eintrag machen?", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .Cancel) { (action) in
            print("ActionSheet cancel")
        }
        let reloadAction = UIAlertAction(title: "Neu laden", style: .Default) { (action) in
            print("ActionSheet reload")
        }
        let destroyAction = UIAlertAction(title: "Eintrag aus Übersicht entfernen", style: .Destructive) { (action) in
            print("ActionSheet deleted")
//            
//            //You can define a sort order
//            var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//            var newRequest = NSFetchRequest(entityName: "Media")
//            let predicate = NSPredicate(format: "id == %@", argumentArray: scan?.valueForKey("id"))
        }
        alertController.addAction(cancelAction)
        alertController.addAction(reloadAction)
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
}
