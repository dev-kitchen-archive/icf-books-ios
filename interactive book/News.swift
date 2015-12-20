//
//  News.swift
//  interactive book
//
//  Created by Andreas Plüss on 20.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import Foundation
import UIKit

class News {
    var title:String
    var description:String
    var image:UIImage
    var shown:Bool = false
    
    init(newsTitle:String, newsDescription:String, newsImage:UIImage) {
        self.title = newsTitle
        self.description = newsDescription
        self.image = newsImage
    }
    
    convenience init(newsTitel:String, newsDescription:String){
        self.init(newsTitle: newsTitel, newsDescription: newsDescription, newsImage: UIImage(named: "back_circle_kap12")!)
    }
    
    convenience init(newsTitel:String, newsImage:UIImage){
        self.init(newsTitle: newsTitel, newsDescription: "...", newsImage: newsImage)
    }
    
    convenience init(newsTitel:String){
        self.init(newsTitle: newsTitel, newsDescription: "...", newsImage: UIImage(named: "back_circle_kap12")!)
    }
}
