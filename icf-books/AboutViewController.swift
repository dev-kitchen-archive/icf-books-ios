//
//  AboutViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 22.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData

class AboutViewController: UITableViewController, UITextFieldDelegate {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var openImprint: UILabel!
    @IBOutlet weak var openFontis: UILabel!
    @IBOutlet weak var openDeveloper: UILabel!
    @IBOutlet weak var openStore: UILabel!
    @IBOutlet weak var followWorship: UILabel!
    @IBOutlet weak var followChurch: UILabel!
    @IBOutlet weak var followLeo: UILabel!
    @IBOutlet weak var devDesc: UILabel!
    @IBOutlet weak var icfDesc: UILabel!
    @IBOutlet weak var leoDesc: UILabel!
    @IBOutlet weak var newsletterTitle: UILabel!
    @IBOutlet weak var newsletterDesc: UILabel!
    @IBOutlet weak var newsletterButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = Color.accent
        
        //newsletter
        nameField.delegate = self
        emailField.delegate = self
        newsletterTitle.text = NSLocalizedString("ABOUT_NEWSLETTER", comment:"stay informed")
        newsletterButton.setTitle(NSLocalizedString("ABOUT_NEWSLETTER_BUTTON", comment:"segn up"), forState: .Normal)
        if let email = userDefaults.objectForKey("newsletter") as? String {
            let mail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let mailText = NSLocalizedString("ABOUT_NEWSLETTER_SIGNEDUP", comment:"already signed up").stringByReplacingOccurrencesOfString("@", withString: mail)
            newsletterDesc.text = mailText
        } else {
            newsletterDesc.text = NSLocalizedString("ABOUT_NEWSLETTER_DESC", comment:"Newsletter description")
        }
        
        //leo
        leoDesc.text = NSLocalizedString("ABOUT_LEO_DESC", comment:"Leo Bigger description")
        followLeo.text = NSLocalizedString("ABOUT_LEO_FOLLOW", comment:"Leo Bigger description")
        
        //icf
        icfDesc.text = NSLocalizedString("ABOUT_CHURCH_DESC", comment:"ICF Church description")
        followChurch.text = NSLocalizedString("ABOUT_CHURCH_FOLLOW", comment:"ICF Church follow")
        followWorship.text = NSLocalizedString("ABOUT_WORSHIP_FOLLOW", comment:"ICF Worship follow")
        openStore.text = NSLocalizedString("ABOUT_STORE", comment:"ICF Online Store")
        
        //dev
        devDesc.text = NSLocalizedString("ABOUT_DEVELOPER_DESC", comment:"Developer Kitchen")
        openDeveloper.text = NSLocalizedString("ABOUT_DEVELOPER", comment:"dev kitchen website")
        
        //imprint / press
        openFontis.text = NSLocalizedString("ABOUT_FONTIS", comment:"Fontis press")
        openImprint.text = NSLocalizedString("ABOUT_IMPRINT", comment:"imprint")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: "Remove all scanned qr code entries?", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel) { (action) in
            print("ActionSheet cancel")
        }
//        let destroyAction = UIAlertAction(title: "remove", style: .Destructive) { (action) in
//            print("ActionSheet deleted")
//            
//            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//            let managedContext = appDelegate.managedObjectContext
//            
//            let fetchRequest = NSFetchRequest(entityName: "Media")
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//            do {
//                try managedContext.executeRequest(deleteRequest)
//                try managedContext.save()
//            } catch let error as NSError {
//                // TODO: handle the error
//                print(error)
//            }
//            
//            
//            //make intro available again
//            self.userDefaults.removeObjectForKey("appAlreadyUsed")
//            self.userDefaults.synchronize()
//        }
        alertController.addAction(cancelAction)
        //alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true) { }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 && indexPath.row == 4 {
            let url = NSURL(string: Api.storeUrl)
            UIApplication.sharedApplication().openURL(url!)
        } else if indexPath.section == 3 && indexPath.row == 2 {
            let url = NSURL(string: Api.devUrl)
            UIApplication.sharedApplication().openURL(url!)
        } else if indexPath.section == 4 && indexPath.row == 0 {
            let url = NSURL(string: Api.fontis)
            UIApplication.sharedApplication().openURL(url!)
        } else if indexPath.section == 4 && indexPath.row == 1 {
            let url = NSURL(string: Api.impressum)
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nameField) {
            nameField.resignFirstResponder()
            emailField.becomeFirstResponder()
            return true
        } else {
            view.endEditing(true)
            return false
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if !Reachability.isConnectedToNetwork() {
            ErrorManager.internetPermission(self)
        } else {
            let name = nameField.text
            let email = emailField.text
            if name?.characters.count >= 1 && isValidEmail(email) {
                RequestManager.postNewsletter(email!, name: name!, completionHandler: { (error) -> (Void) in
                    dispatch_async(dispatch_get_main_queue()) {
                        if error != nil {
                            ErrorManager.newsletterFail(self)
                        } else {
                            self.userDefaults.setValue(email, forKey: "newsletter")
                            self.userDefaults.synchronize()
                            
                            //define description informing that signup was successful
                            self.newsletterDesc.text = NSLocalizedString("ABOUT_NEWSLETTER_SIGNEDUP", comment:"already signed up").stringByReplacingOccurrencesOfString("@", withString: email!)
                            
                            //reset fileds
                            self.nameField.text = nil
                            self.emailField.text = nil
                            
                            //calling altert to inform user about success and dismiss the keyboard
                            ErrorManager.newsletterSuccess(self, callback: {self.view.endEditing(true)})
                        }
                    }
                })
            } else {
                ErrorManager.newsletterInvalid(self)
            }
        }
    }
    
    func isValidEmail(testStr:String?) -> Bool {
        if testStr != nil {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(testStr)
        } else {
            return false
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
/*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
       
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
