//
//  Media+CoreDataProperties.swift
//  icf-books
//
//  Created by Andreas Plüss on 19.02.16.
//  Copyright © 2016 devkitchen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Media {

    @NSManaged var id: String?
    @NSManaged var type: String?
    @NSManaged var title: String?
    @NSManaged var teaser: String?
    @NSManaged var thumbnail_url: String?
    @NSManaged var file_url: String?
    @NSManaged var thumbnail_data: NSData?

}
