//
//  NewTaskModel.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import Foundation
import GameKit

class NewTaskModel  {
    var taskDescription = ""
    var priority        = 4
    var taskCompleted   = false
    var isImportant     = false
    var isUrgent        = false
    var taskId          = GKRandomSource.sharedRandom().nextInt()
    
    func computeTaskPriority() -> Void {
        
        if isImportant == true && isUrgent == true  {
            priority = 1
        }
        else if isImportant == true && isUrgent == false {
            priority = 2
        }
        else if isImportant == false && isUrgent == true {
            priority = 3
        }
        else {
           priority  = 4
        }
    }
    
    func setImportantAndUrgent()-> Void {
        
        switch priority {
        case 1:
            isImportant = true
            isUrgent    = true
        case 2:
            isImportant = true
            isUrgent    = false
        case 3:
            isImportant = false
            isUrgent    = true
        case 4:
            isImportant = false
            isUrgent    = false
        default:
            isImportant = false
            isUrgent    = false
        }
    }
}