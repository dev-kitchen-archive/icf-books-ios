//
//  FirstTimeUseViewController.swift
//  interactive book
//
//  Created by Andreas Plüss on 20.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    let contentImages = ["intro0",
                         "intro1",
                         "intro2",
                         "intro3"];
    let contentTitle = ["Ester",
                        "Scanne",
                        "Forsche",
                        "Viel Spass"];
    let contentDescription = ["Kaufe hier das Buch",
                              "Du kanst QR-Codes die sich im Buch befinden Scannen und zusätzliche Inhalte anschauen.",
                              "Deine bereits gescannten Inhalte sind stehts nur ein Klick entfent.",
                              "Wir hoffen dir gefällt die App!"];
    var pageCount:Int = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageCount = contentImages.count
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if pageCount > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        appearance.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! IntroPageController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! IntroPageController
        
        if itemController.itemIndex+1 < pageCount {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> IntroPageController? {
        
        if itemIndex < pageCount {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("introPageView") as! IntroPageController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            pageItemController.itemTitle = contentTitle[itemIndex]
            pageItemController.itemDescription = contentDescription[itemIndex]
            
            if itemIndex == (pageCount - 1) {
                pageItemController.visible = true
            }
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageCount
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
