//
//  TaskDataAccess.swift
//  ToDo
//
//  Created by Nate Jackson on 7/16/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation
import CoreData

protocol TDDataAccess {
    func addTask(task: NewTaskModel)
    func getTaskForPriority(priority:Int, processResults:(Array<Tasks>)-> Void)
    func deleteTask(taskId:Int)
    func updateTask(task: NewTaskModel)
    func updateTaskAsCompleted(isCompleted:Bool, forId taskId:Int)
}

class CoreDataAccess: TDDataAccess {
    
    private let coreDataMOC: NSManagedObjectContext?
    private let appMOC: NSManagedObjectContext?
    
    init() {
        let delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appMOC        = delegate.managedObjectContext
        coreDataMOC   = NSManagedObjectContext(concurrencyType:.PrivateQueueConcurrencyType)
        coreDataMOC?.parentContext = appMOC
    }
    
    func addTask(task: NewTaskModel) {
        
        coreDataMOC?.performBlockAndWait({
            
            let newTask = NSEntityDescription.insertNewObjectForEntityForName("Tasks", inManagedObjectContext: self.coreDataMOC!) as! Tasks
            
            newTask.taskId    = NSNumber(integer: task.taskId)
            newTask.priority  = NSNumber(integer: task.priority)
            newTask.completed = NSNumber(bool: task.taskCompleted)
            newTask.summary   = task.taskDescription
            
            do {
                try self.coreDataMOC?.save()
            }
            catch {
                print("There was a problem!")
            }
        })
        
        appMOC?.performBlock {
            
            do {
                
                try self.appMOC!.save()
            }
            catch {
                print("There was a problem!")
            }
        }
    }
 
    func getTaskForPriority(priority:Int, processResults:(Array<Tasks>)-> Void) {
       
        var tempTask = [Tasks]()
        
        coreDataMOC?.performBlockAndWait {
            
            let fetchRequest = NSFetchRequest(entityName: "Tasks")
            let predicate    = NSPredicate(format:"priority == %d", priority)
            
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false;
            
            do {
                tempTask = try self.coreDataMOC?.executeFetchRequest(fetchRequest) as! [Tasks]
            }
            catch {
                print("There was a problem!")
            }
        }
        
        processResults(tempTask)
    }
    
    func deleteTask(taskId:Int) {
        
        coreDataMOC?.performBlockAndWait({
            let fetchRequest = NSFetchRequest(entityName: "Tasks")
            let predicate    = NSPredicate(format:"taskId == %d", taskId)
            
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false;
            
            do {
                  let tempTaskList = try self.coreDataMOC?.executeFetchRequest(fetchRequest) as! [Tasks]
                
                for itemTask: Tasks in tempTaskList {
                    self.coreDataMOC?.deleteObject(itemTask)
                }
                
                try self.coreDataMOC?.save()
            }
            catch {
                print("There was a problem!")
            }
        })
        
        appMOC?.performBlock {
            
            do {
                
                try self.appMOC!.save()
            }
            catch {
                print("There was a problem!")
            }
        }
    }
    
    func updateTask(task: NewTaskModel) {
        
        coreDataMOC?.performBlockAndWait({
            
            let fetchRequest = NSFetchRequest(entityName: "Tasks")
            let predicate    = NSPredicate(format:"taskId == %d", task.taskId)
            
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false;
            
            do {
                let tempTaskList = try self.coreDataMOC?.executeFetchRequest(fetchRequest) as! [Tasks]
                
                for itemTask: Tasks in tempTaskList {
                    
                    itemTask.taskId    = NSNumber(integer: task.taskId)
                    itemTask.priority  = NSNumber(integer: task.priority)
                    itemTask.completed = NSNumber(bool: task.taskCompleted)
                    itemTask.summary   = task.taskDescription
                }
                
                try self.coreDataMOC?.save()
            }
            catch {
                print("There was a problem!")
            }
        })
        
        appMOC?.performBlock {
            
            do {
                
                try self.appMOC!.save()
            }
            catch {
                print("There was a problem!")
            }
        }
    }
    
    func updateTaskAsCompleted(isCompleted:Bool, forId taskId:Int) {
        
        coreDataMOC?.performBlockAndWait({
            
            let fetchRequest = NSFetchRequest(entityName: "Tasks")
            let predicate    = NSPredicate(format:"taskId == %d", taskId)
            
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false;
            
            do {
                let tempTaskList = try self.coreDataMOC?.executeFetchRequest(fetchRequest) as! [Tasks]
                
                for itemTask: Tasks in tempTaskList {
                    itemTask.completed = NSNumber(bool: isCompleted)
                }
                
                try self.coreDataMOC?.save()
            }
            catch {
                print("There was a problem!")
            }
        })
        
        appMOC?.performBlock {
            
            do {
                
                try self.appMOC!.save()
            }
            catch {
                print("There was a problem!")
            }
        }
    }
}
