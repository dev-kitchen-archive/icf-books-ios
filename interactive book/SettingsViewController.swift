//
//  SettingsViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 17.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var tableData = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        populateTableData()
        
        table.delegate = self
        table.dataSource = self
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("horizontalInfoCell") as? HorizontalCell
        if cell == nil {
            cell = HorizontalCell(style: UITableViewCellStyle.Default, reuseIdentifier: "horizontalInfoCell")
        }
        
        cell!.cellDescriptions = tableData[indexPath.row]
        
        //        let myBackView = UIView(frame:cell!.frame)
        //        myBackView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
        //        cell!.selectedBackgroundView = myBackView
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let newCell = tableView.cellForRowAtIndexPath(indexPath)
        //newCell?.backgroundColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }

    func populateTableData() {
        tableData.append(["Desctiption for first Item.", "Desctiption for second Item.", "Desctiption for third Item.", "Desctiption for forth Item."])
        tableData.append(["Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor", "sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."])
    }
}
