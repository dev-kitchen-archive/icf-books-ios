//
//  ErrorManager.swift
//  icf-books
//
//  Created by Andreas Plüss on 22.07.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import Foundation
import UIKit

class ErrorManager {

    /* 
     User forced to check settings, as camera access is necessary
     for scanning qr codes
    */
    static func cameraPermission(presenter:UIViewController) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("ERROR_CAMERA", comment:"no camera access"),
                                      message: NSLocalizedString("ERROR_CAMERA_DESC", comment:"no camera access explainded"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: NSLocalizedString("ERROR_CAMERA_BTN", comment:"go to settings action"),
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
     internet conection is limited through bad connection or restricted
     mobile data access in permissions
    */
    static func internetPermission(presenter:UIViewController) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("ERROR_INTERNET", comment:"no connection"),
                                      message: NSLocalizedString("ERROR_INTERNET_DESC", comment:"no connection explainded"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: NSLocalizedString("ERROR_SETTINGS_BTN", comment:"go to settings action"),
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("ERROR_IGNORE_BTN", comment:"ignore action"),
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func badUrl(presenter:UIViewController) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("ERROR_BAD_URL", comment:"URL not valid"),
                                      message: NSLocalizedString("ERROR_BAD_URL_DESC", comment:"URL not valid explainded"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: NSLocalizedString("ERROR_IGNORE_BTN", comment:"ignore action"),
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func newsletterFail(presenter:UIViewController) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("ERROR_NEWSLETTER",comment:"signup failed"),
                                      message: NSLocalizedString("ERROR_NEWSLETTER_DESC", comment:"signup failed explainded"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: NSLocalizedString("ERROR_NEWSLETTER_BTN", comment:"ignore action"),
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func newsletterInvalid(presenter:UIViewController) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("ABOUT_NEWSLETTER_SIGNUP_INVALID", comment:"invalid data"),
                                      message: NSLocalizedString("ABOUT_NEWSLETTER_SIGNUP_INVALID_DESC", comment:"invalid data explainded"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func newsletterSuccess(presenter:UIViewController, callback:()->()) {
        //Alert
        let alert = UIAlertController(title: NSLocalizedString("SUCCESS_NEWSLETTER", comment:"signup success"),
                                      message: NSLocalizedString("SUCCESS_NEWSLETTER_DESC", comment:"signup success description"),
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        //Buttons
        alert.addAction(UIAlertAction(title: NSLocalizedString("SUCCESS_NEWSLETTER_BTN", comment:"ignore action"),
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        //Present action
        presenter.presentViewController(alert, animated: true, completion: nil)
        
        //run callback if
        callback()
    }
    
}