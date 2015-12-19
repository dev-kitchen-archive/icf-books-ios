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
        
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("infosContainerCell") as? MultipleInfosCell
            if cell == nil {
                cell = MultipleInfosCell(style: UITableViewCellStyle.Default, reuseIdentifier: "infosContainerCell")
            }
            
            cell!.cellDescriptions = ["One", "Two", "Three", "devkitchen", String(indexPath.row), String(tableData[indexPath.row]), "Bye"]
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? StartPageCell
            if cell == nil {
                cell = StartPageCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            cell!.delegate = self
            cell!.cellDescription.text = tableData[indexPath.row]
            cell!.cellImage.image = UIImage(named: "back_circle_kap12")
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        } else {
            return 180
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func alert(message: String) {
        let textToShare = message
        if let myWebsite = NSURL(string: "http://dev.kitchen/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
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

