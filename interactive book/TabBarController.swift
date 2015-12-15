//
//  TabBarController.swift
//  interactive book
//
//  Created by Andreas Plüss on 15.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var iconNames = ["home","scan","contact"]
    var iconColor = UIColor.whiteColor()
    var iconColorSelected = UIColor(red:1, green:0.4, blue:0.38, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // shrink to 40 from default around 50 px
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 40
        tabFrame.origin.y = self.view.frame.size.height - 40
        self.tabBar.frame = tabFrame
        
        //set color for selected images
        self.tabBar.tintColor = self.iconColorSelected
        
        for index in 0...((self.tabBar.items?.count)! - 1) {
            //get tabbar element
            let tabBarIcn:UITabBarItem = self.tabBar.items![index]
            
            //remove its title
            tabBarIcn.title = nil
            
            //shink and reposition it to take space from missing title
            //tabBarIcn.imageInsets = UIEdgeInsets(top: 10, left: 4, bottom: -2, right: 4)
            
            //set its icon accourdin to preset variable
            //tabBarIcn.image = UIImage(named: "second")!.imageWithRenderingMode(.AlwaysOriginal)
            //tabBarIcn.selectedImage = UIImage(named: "selected_" + self.iconNames[index])
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
    override func viewWillLayoutSubviews() {
        

    }
}
