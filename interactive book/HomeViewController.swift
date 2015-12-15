//
//  FirstViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 08.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? StartPageCell
        if cell == nil {
            cell = StartPageCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
        }
        
        cell!.cellDescription.text = tableData[indexPath.row]
        cell!.cellImage.image = UIImage(named: "first")
        
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
        tableData.append("Desctiption for first Item.")
        tableData.append("Desctiption for second Item.")
        tableData.append("Desctiption for third Item.")
        tableData.append("Desctiption for forth Item.")
        tableData.append("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
    }
}

