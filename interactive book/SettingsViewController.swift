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
}
