//
//  WelcomeController.swift
//  icf-books
//
//  Created by Andreas Plüss on 06.05.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        //show intro to user, if he opens the app for the first time
        startWithView(!self.userDefaults.boolForKey("appAlreadyUsed"))
    }
    
    func startWithView(intro:Bool) {
        print(intro)
        if intro {
            self.performSegueWithIdentifier("showIntro", sender: self)
        } else {
            self.performSegueWithIdentifier("showHome", sender: self)
        }
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

}
