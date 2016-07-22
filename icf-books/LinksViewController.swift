//
//  LinksViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 22.07.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class LinksViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.restorationIdentifier == "leo" {
            
            if indexPath.row == 0 {
                let url = NSURL(string: Api.leoBlog)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 1 {
                let url = NSURL(string: Api.leoInsta)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 2 {
                let url = NSURL(string: Api.leoFB)
                UIApplication.sharedApplication().openURL(url!)
            }
        
        } else if self.restorationIdentifier == "worship" {
            
            if indexPath.row == 0 {
                let url = NSURL(string: Api.worshipBlog)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 1 {
                let url = NSURL(string: Api.worshipInsta)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 2 {
                let url = NSURL(string: Api.worshipFB)
                UIApplication.sharedApplication().openURL(url!)
            }
            
        } else if self.restorationIdentifier == "church" {
            
            if indexPath.row == 0 {
                let url = NSURL(string: Api.churchBlog)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 1 {
                let url = NSURL(string: Api.churchInsta)
                UIApplication.sharedApplication().openURL(url!)
            } else if indexPath.row == 2 {
                let url = NSURL(string: Api.churchFB)
                UIApplication.sharedApplication().openURL(url!)
            }
            
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

}
