//
//  Tasks+CoreDataProperties.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tasks {

    @NSManaged var completed: NSNumber?
    @NSManaged var priority: NSNumber?
    @NSManaged var summary: String?
    @NSManaged var taskId: NSNumber?

}
