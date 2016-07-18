//
//  AboutViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 22.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData

class AboutViewController: UITableViewController {

    @IBOutlet weak var newsletterShadow: UIView!
    @IBOutlet weak var newsletterContainer: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = Color.accent
        
        //Button
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.blackColor().CGColor
        
        //Newsletter
        newsletterContainer.layer.borderWidth = 0.5
        newsletterContainer.layer.borderColor = UIColor.lightGrayColor().CGColor
        newsletterContainer.layer.cornerRadius = 5
        newsletterContainer.clipsToBounds = true
        
        newsletterShadow.layer.shadowColor = UIColor.blackColor().CGColor
        newsletterShadow.layer.shadowOffset = CGSize(width: 0, height: 1)
        newsletterShadow.layer.shadowOpacity = 0.2
        newsletterShadow.layer.shadowRadius = 2.4
        newsletterShadow.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: "Alle gescannten Einträge werden gelöscht", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .Cancel) { (action) in
            print("ActionSheet cancel")
        }
        let destroyAction = UIAlertAction(title: "Löschen", style: .Destructive) { (action) in
            print("ActionSheet deleted")
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Media")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try managedContext.executeRequest(deleteRequest)
                try managedContext.save()
            } catch let error as NSError {
                // TODO: handle the error
            }
            
            
            //make intro available again
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.removeObjectForKey("appAlreadyUsed")
            userDefaults.synchronize()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) { }
        
    }

    @IBAction func icfBooks(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.icf.ch/books/")!)
    }
    
    @IBAction func icfWorship(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.icf-worship.com")!)
    }
    
    @IBAction func devkitchen(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://dev.kitchen/")!)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            print("party")
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
    
    // MARK: - Table view data source
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
