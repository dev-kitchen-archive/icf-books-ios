//
//  MasterViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 23.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    let accentColor = Color.accent

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = accentColor
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
