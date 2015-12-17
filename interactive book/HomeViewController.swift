//
//  FirstViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 08.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PressButtonProtocol {
    
    @IBOutlet weak var table: UITableView!
    var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.delegate = self
        table.dataSource = self
        populateTableData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 || indexPath.row == 5 {
            var cell = tableView.dequeueReusableCellWithIdentifier("infosContainerCell") as? MultipleInfosCell
            if cell == nil {
                cell = MultipleInfosCell(style: UITableViewCellStyle.Default, reuseIdentifier: "infosContainerCell")
            }
            
            cell!.cellDescriptions = ["hoi", "das isch dZelle nr", String(indexPath.row), "da isch nochli text" , String(tableData[indexPath.row]), "ade"]
            
            //        let myBackView = UIView(frame:cell!.frame)
            //        myBackView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
            //        cell!.selectedBackgroundView = myBackView
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? StartPageCell
            if cell == nil {
                cell = StartPageCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            cell!.delegate = self
            cell!.cellDescription.text = tableData[indexPath.row]
            cell!.cellImage.image = UIImage(named: "back_circle_kap12")
            
            //        let myBackView = UIView(frame:cell!.frame)
            //        myBackView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
            //        cell!.selectedBackgroundView = myBackView
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let newCell = tableView.cellForRowAtIndexPath(indexPath)
        //newCell?.backgroundColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "interact book alert title", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "weg dämit", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "nai", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "mol", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "weiss nöd", style: UIAlertActionStyle.Default,handler: nil))

        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func populateTableData() {
        tableData.append("Desctiption for first Item.")
        tableData.append("Desctiption for second Item.")
        tableData.append("Desctiption for third Item.")
        tableData.append("Desctiption for forth Item.")
        tableData.append("Desctiption for fifth Item.")
        tableData.append("Desctiption for sixth Item.")
        tableData.append("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
        tableData.append("Desctiption for eighth Item.")
    }
}

