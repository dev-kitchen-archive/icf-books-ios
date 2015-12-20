//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class IntroPageController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = pageImage {
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
    var visible: Bool = false {
    
        didSet {
        
            if let button = closeButton {
                button.hidden = visible
            }
        }
    }
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageDescription: UILabel!
    @IBOutlet weak var pageImage: UIImageView?
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = String(itemIndex)
        pageImage!.image = UIImage(named: imageName)
        closeButton.hidden = !visible
    }
    
    @IBAction func closeIntro(sender: AnyObject) {
        
    }
}
