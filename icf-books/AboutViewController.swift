//
//  AboutViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 22.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import CoreData

class AboutViewController: UIViewController {

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
                try managedContext.executeRequest(fetchRequest)
                try managedContext.save()
            } catch let error as NSError {
                // TODO: handle the error
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(destroyAction)

        self.presentViewController(alertController, animated: true) { }

    }
}
