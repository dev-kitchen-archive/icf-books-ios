//
//  Media.swift
//  icf-books
//
//  Created by Andreas Plüss on 19.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Media: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    static func getById(id:String) -> Media? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Media")
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate

        var returnMedia:Media? = nil
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            if result.count > 0 {
                returnMedia = result[0] as! NSManagedObject as? Media
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return returnMedia
    }
    
    static func saveNewEntity(mediaDict:NSDictionary) -> Bool {
        
        var savingSuccessful = false

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Media", inManagedObjectContext:managedContext)
        let media = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        media.setValue(mediaDict.valueForKey("id"), forKey: "id")
        media.setValue(mediaDict.valueForKey("type"), forKey: "type")
        media.setValue(mediaDict.valueForKey("title"), forKey: "title")
        media.setValue(mediaDict.valueForKey("teaser"), forKey: "teaser")
        media.setValue(mediaDict.valueForKey("thumbnailData"), forKey: "thumbnail_data")
        media.setValue(mediaDict.valueForKey("typeData"), forKey: "type_data")
        
        do {
            try managedContext.save()
            savingSuccessful = true
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            savingSuccessful = false
        }
        
        return savingSuccessful
    }
    
//    media class needs to do
//    - check if id of a media exists (get by id)
//    - return the image of a certain id as UIImage
//    - speichere aus json in coredata !!!

}
