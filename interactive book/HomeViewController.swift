//
//  FirstViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 08.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonPressProtocol {
    
    @IBOutlet weak var table: UITableView!
    var tableData = [AnyObject]()
    var lastIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentIntroView()
        
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
        
        if tableData[indexPath.row] is NewsGroup {
            var cell = tableView.dequeueReusableCellWithIdentifier("multipleNewsCell") as? NewsGroupCell
            if cell == nil {
                cell = NewsGroupCell(style: UITableViewCellStyle.Default, reuseIdentifier: "multipleNewsCell")
            }
            
            cell!.newsGroup = tableData[indexPath.row] as? NewsGroup
            
            return cell!
        } else if tableData[indexPath.row] is News {
            var cell = tableView.dequeueReusableCellWithIdentifier("singleNewsCell") as? NewsCell
            if cell == nil {
                cell = NewsCell(style: UITableViewCellStyle.Default, reuseIdentifier: "singleNewsCell")
            }
            
            cell!.delegate = self
            let news = tableData[indexPath.row] as? News
  
            cell!.cellTitle.text = news!.title
            cell!.cellDescription.text = news!.description
            cell!.cellImage.image = news!.image
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("singleNewsCell")
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableData[indexPath.row] is NewsGroup {
            return 230
        } else {
            return 140
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row > lastIndex {
            TipInCellAnimator.animate(cell)
        }
        lastIndex = indexPath.row
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func actionOnPress(message: String) {
        let textToShare = message
        if let myWebsite = NSURL(string: "http://dev.kitchen/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    func populateTableData() {
        let multipleNews = NewsGroup(news: [News(newsTitel: "Group News 1", newsDescription: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam"),
                                            News(newsTitel: "Group News 2", newsDescription: "Desctiption for second Item"),
                                            News(newsTitel: "Group News 3", newsDescription: "Carpe diem."),
                                            News(newsTitel: "Group News 4", newsDescription: "Desctiption for Item number 4"),
                                            News(newsTitel: "Group News 5", newsDescription: "At vero eos et accusam et justo duo dolores et ea rebum."),
                                            News(newsTitel: "Group News 6", newsDescription: "Sed diam voluptua."),])
        
        tableData.append(multipleNews)
        tableData.append(News(newsTitel: "Title number one", newsDescription: "Desctiption for first Item"))
        tableData.append(News(newsTitel: "Title number two", newsDescription: "Desctiption for second Item"))
        tableData.append(News(newsTitel: "Title number three", newsDescription: "Desctiption for third Item"))
        tableData.append(News(newsTitel: "Title number four", newsDescription: "Desctiption for forth Item"))
        tableData.append(News(newsTitel: "Title number five", newsDescription: "Desctiption for Item number 5"))
        tableData.append(News(newsTitel: "Title number six", newsDescription: "Desctiption for Item number 6"))
        tableData.append(News(newsTitel: "Title number seven", newsDescription: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."))
        tableData.append(News(newsTitel: "Title number eight", newsDescription: "Desctiption for Item number 8"))
    }
    
    func presentIntroView() {
        //check if user uses the app for the first time to present him the IntroductionViewController
        if(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce") != true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("introView")
            self.presentViewController(vc, animated: true, completion: nil)
            
            // This is the first launch ever
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}

