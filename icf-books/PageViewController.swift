//
//  PageViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 02.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var sliderDelegate: IntroPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextSlideButton(sender: AnyObject) {
        if sliderDelegate != nil {
            sliderDelegate!.setViewControllers([sliderDelegate!.orderedViewControllers.first!],
                direction: .Forward,
                animated: true,
                completion: nil)
        }
    }
    
    @IBAction func finishIntroButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main ", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("rootView")
        self.presentViewController(vc, animated: true, completion: nil)
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
