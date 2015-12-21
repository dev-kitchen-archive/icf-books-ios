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
    var itemTitle: String = "" {
        didSet {
            if let title = pageTitle {
                title.text = itemTitle
            }
        }
    }
    var itemDescription: String = "" {
        didSet {
            if let desc = pageDescription {
                desc.text = itemDescription
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
        pageTitle.text = itemTitle
        pageDescription.text = itemDescription
        pageImage!.image = UIImage(named: imageName)
        closeButton.hidden = !visible
    }
    
    @IBAction func closeIntro(sender: AnyObject) {
        
    }
}
