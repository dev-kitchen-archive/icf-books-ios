//
//  HomeViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 16.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonPressProtocol {

    @IBOutlet weak var table: UITableView!
    var actionButton: ActionButton!
    var tableData = ["one","two","three","three","three"]
    //var tableData = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        
        //add floating action button
        actionButton = ActionButton(attachedToView: self.view, items: nil)
        actionButton.action = { button in button.openView() }
        actionButton.setTitle("+", forState: .Normal)
        actionButton.delegate = self
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData.count < 1 {
            return 1
        } else {
            return tableData.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if tableData.count < 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("infoImageCell") as? InfoImageTableViewCell
            if cell == nil {
                cell = InfoImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "infoImageCell")
            }
            
            //cell!.titel oder so
            
            return cell!
        } else if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("progressCell") as? ProgressTableViewCell
            if cell == nil {
                cell = ProgressTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "progressCell")
            }
            
            //cell!.titel oder so

            return cell!
        } else {
            var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as? ContentTableViewCell
            if cell == nil {
                cell = ContentTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myCell")
            }
            
            //cell!.titel oder so
            
            return cell!
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableData.count < 1 {
            return 600
        } else if indexPath.row == 0 {
            return 90
        } else {
            return 120
        }
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let destination = storyboard.instantiateViewControllerWithIdentifier("DetailView") as! DetailViewController
//        navigationController?.pushViewController(destination, animated: true)
//        
//        //performSegueWithIdentifier("segue", sender: self)
//    }
    
    func actionOnPress(viewCtrl: OpenView) {
        if viewCtrl == OpenView.Scanner {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let destination = storyboard.instantiateViewControllerWithIdentifier("DetailView") as! DetailViewController
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    
}

