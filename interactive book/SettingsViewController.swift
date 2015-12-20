//
//  SettingsViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 17.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

/// use of this view is not yet defined
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var tableData = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func firstTimeUse(sender: AnyObject) {
//        // reset value for first time use
//        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "HasLaunchedOnce")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
        // go to HomeViewController, where IntroView is presented depending on the UserDefaults
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("introView")
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
}
