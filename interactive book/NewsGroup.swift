//
//  NewsGroup.swift
//  interactive book
//
//  Created by Andreas Plüss on 20.12.15.
//  Copyright © 2015 devkitchen. All rights reserved.
//

import Foundation
import UIKit

class NewsGroup {
    var shown:Bool = false
    var news = [News]()
    var entries: Int
    
    /**
     creats same amount of titles, descriptions and images. the values of the arrays are related by the same index. as reference it counts how many titles exist and reduces the descriptions and images to same amount. if there are to few descriptions or images, their array is filled with a standard value
     
     - parameter newsTitles:       all titles for the News. index is news id
     - parameter newsDescriptions: the description for the title with same index
     - parameter newsImages:       the image for the title with same index
     
     - returns: NewsGroup Instance which contains multiple News
     */
    init(newsTitles:[String], newsDescriptions:[String], newsImages:[UIImage]) {
        entries = newsTitles.count
        
        var descriptions = validateNumberOfDescription(newsDescriptions)
        var images = validateNumberOfImages(newsImages)
        
        for index in 0...entries {
            news.append(News(newsTitle: newsTitles[index], newsDescription: descriptions[index], newsImage: images[index]))
        }
    }
    
    convenience init(newsTitles:[String], newsDescriptions:[String]){
        self.init(newsTitles: newsTitles, newsDescriptions: newsDescriptions, newsImages: [UIImage(named: "back_circle")!])
    }
    
    init(news:[News]) {
        entries = news.count
        self.news = news
    }
    
    func validateNumberOfDescription(descriptions:[String], standardDescription:String = "...") -> [String]{
        if descriptions.count > entries {
            return Array(descriptions.prefix(entries))
        } else {
            var newDescriptions = descriptions
            while newDescriptions.count < entries {
                newDescriptions.append(standardDescription)
            }
            return newDescriptions
        }
    }
    
    func validateNumberOfImages(images:[UIImage], standardImage:UIImage = UIImage(named: "back_circle")!) -> [UIImage]{
        if images.count > entries {
            return Array(images.prefix(entries))
        } else {
            var newImages = images
            while newImages.count < entries {
                newImages.append(standardImage)
            }
            return newImages
        }
    }
}
