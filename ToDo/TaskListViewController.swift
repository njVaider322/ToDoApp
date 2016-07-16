//
//  TaskListViewController.swift
//  ToDo
//
//  Created by Nate Jackson on 7/14/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TaskListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TaskCompleted {

    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskListTableView:        UITableView!
    @IBOutlet weak var categoryLabel:            UILabel!
    @IBOutlet weak var itemsCountBarButton:      UIBarButtonItem!
    
    var toDoTask: Tasks?
    let matrixCategories = ["IMPORTANT AND URGENT","IMPORTANT BUT NOT URGENT","NOT IMPORTANT BUT URGENT", "NOT IMPORTANT AND NOT URGENT"]
    var taskList    = Array<Tasks>()
    let taskListQueue: dispatch_queue_t = dispatch_queue_create("com.ToDo.TaskListQueue",DISPATCH_QUEUE_SERIAL)
    var isEditingSelectedTask = false
    var taskDataAccess: TDDataAccess = CoreDataAccess()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontSize       = CGFloat(18)
        let textColor      = UIColor(red: 0.008, green: 0.784, blue: 0.819, alpha: 1.0)
        let textAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(fontSize), NSForegroundColorAttributeName:textColor]
            
        navigationController?.navigationBar.titleTextAttributes = textAttributes
      
        let segmentIndex = categorySegmentedControl.selectedSegmentIndex
        categoryLabel.text = matrixCategories[segmentIndex]
        populateTaskList(segmentIndex + 1)
        
        taskListTableView.reloadData()
        
        categorySegmentedControl.layer.cornerRadius = 0.6
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: Segment Control Action Method
    @IBAction func handleSelectedSegmentDidChange(sender: UISegmentedControl) {
        
        let segmentedControl = sender
        let segmentIndex     = segmentedControl.selectedSegmentIndex
        let priority = segmentIndex + 1
    
        populateTaskList(priority)
        categoryLabel.text = matrixCategories[segmentIndex]
    }
    
    // MARK: UITableViewDelegate and UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfTasks = 1
        
        if taskList.count > 0 {
            numberOfTasks = taskList.count
        }
        return numberOfTasks
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cellHeight = CGFloat(44.0)
        
        if taskList.count > 0 {
            cellHeight += calculateHeightAtIndexPath(indexPath);
            cellHeight += CGFloat(20.0)
        }
    
        return cellHeight;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCellWithIdentifier("TaskListCellViewID", forIndexPath: indexPath) as! TaskListCellView
        
        if taskList.count > 0 {
            taskCell.taskDescription.text = taskList[indexPath.row].summary
            taskCell.item = indexPath.row
            taskCell.taskSelected = taskList[indexPath.row].completed!.boolValue
            taskCell.delegate = self
            taskCell.taskComplete.hidden = false
        }
        else {
            taskCell.taskDescription.text = ""
            taskCell.taskComplete.hidden = true
        }
        
        return taskCell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{action, indexpath in
            if self.taskList.count > 0 {
                self.isEditingSelectedTask = true
                self.toDoTask = self.taskList[indexPath.row]
                self.performSegueWithIdentifier("NewItem", sender: self)
                let segmentIndex = self.categorySegmentedControl.selectedSegmentIndex
                self.populateTaskList(segmentIndex + 1)
            }
        });
        
        editRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0)
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            if self.taskList.count > 0 {
                self.toDoTask = self.taskList[indexPath.row]
                let taskId = (self.toDoTask?.taskId?.integerValue)!
                self.taskDataAccess.deleteTask(taskId)
                let segmentIndex = self.categorySegmentedControl.selectedSegmentIndex
                self.populateTaskList(segmentIndex + 1)
            }
        })
        
        return [deleteRowAction, editRowAction]
    }
    
    func calculateHeightAtIndexPath(indexPath: NSIndexPath)-> CGFloat {
    
        var heightValue:CGFloat   = 1.0;
        let fontSizeValue:CGFloat = 15.0;
        
        let taskDescription = taskList[indexPath.row].summary! as NSString
        
        let rect:CGRect = taskDescription.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width, CGFloat.max), options:.UsesLineFragmentOrigin, attributes:[NSFontAttributeName:UIFont.systemFontOfSize(fontSizeValue)], context: nil)
            
        heightValue = rect.size.height;
    
        return heightValue;
    }
    
    func populateTaskList(priority: Int)-> Void {
        
        taskList.removeAll()
        
        dispatch_async(taskListQueue) {
            
            self.taskDataAccess.getTaskForPriority(priority, processResults: { (resultsArray) in
                self.taskList.appendContentsOf(resultsArray)
             
                dispatch_async(dispatch_get_main_queue(), {
             
                    if self.taskList.count > 0 {
                        self.taskListTableView?.reloadData()
                        self.itemsCountBarButton.title = " \(self.taskList.count) Item(s)"
                    }
                })
            })
        }
        itemsCountBarButton.title = " \(taskList.count) Item(s)"
        taskListTableView.reloadData()
    }

    // MARK: - TaskCompleted methods
    func markTaskAsCompleted(isCompleted: Bool, selectItem: Int) {
      
        let selectedTask = taskList[selectItem]
        selectedTask.completed = isCompleted
        self.toDoTask = taskList[selectItem]
        
        taskDataAccess.updateTaskAsCompleted(isCompleted, forId:(self.toDoTask?.taskId?.integerValue)!)
    }
    
    // MARK: - prepareForSegue Method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "NewItem" {
            
            if isEditingSelectedTask {
                let editTask = segue.destinationViewController as! NewTaskViewController
                editTask.initializeViewController(toEdit: toDoTask!)
                isEditingSelectedTask = false
            }
        }
    }
    
    // MARK: - Core Data Access method
    func didModifyDataBase()-> Void {
        
        let segmentIndex = categorySegmentedControl.selectedSegmentIndex
        populateTaskList(segmentIndex + 1)

    }
}