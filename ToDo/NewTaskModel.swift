//
//  NewTaskModel.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import Foundation

class NewTaskModel  {
    var taskDescription = ""
    var priority        = 4
    var taskCompleted   = false
    var isImportant     = false
    var isUrgent       = false
    
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
}