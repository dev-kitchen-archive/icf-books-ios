//
//  IntroPageViewController.swift
//  icf-books
//
//  Created by Andreas Plüss on 02.03.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit

class IntroPageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stryboard = UIStoryboard(name: "IntroSlides", bundle: nil)
        let vc1 = stryboard.instantiateViewControllerWithIdentifier("infoPageOne") as! PageViewController
        let vc2 = stryboard.instantiateViewControllerWithIdentifier("infoPageTwo") as! PageViewController
        let vc3 = stryboard.instantiateViewControllerWithIdentifier("infoPageThree") as! PageViewController
        
        vc1.sliderDelegate = self
        vc2.sliderDelegate = self
        vc3.sliderDelegate = self
        
        orderedViewControllers = [vc1, vc2, vc3]
        

        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                direction: .Forward,
                animated: true,
                completion: nil)
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

}

// MARK: UIPageViewControllerDataSource

extension IntroPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            guard orderedViewControllersCount != nextIndex else {
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
//                return 0
//        }
//        
//        return firstViewControllerIndex
//    }
    
}
