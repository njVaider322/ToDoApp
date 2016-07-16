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

    @IBOutlet weak var quadOneButton:     UIButton!
    @IBOutlet weak var quadTwoButton:     UIButton!
    @IBOutlet weak var quadThreeButton:   UIButton!
    @IBOutlet weak var quadFourButton:    UIButton!
    @IBOutlet weak var matrixCategoryCollectionView: UICollectionView!
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var categoryLabel:     UILabel!
    
    var toDoTask: Tasks?
    let matrixCategories = ["IMPORTANT AND URGENT","IMPORTANT BUT NOT URGENT","NOT IMPORTANT BUT URGENT", "NOT IMPORTANT AND NOT URGENT"]
    var mocTaskList = Array<MocTask>()
    var taskList    = Array<MocTask>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add a border to the buttons
        quadOneButton.layer.borderColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.784), blue: CGFloat(0.831), alpha: CGFloat(1.0)).CGColor
        quadOneButton.layer.borderWidth = CGFloat(1.0)
        quadTwoButton.layer.borderColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.784), blue: CGFloat(0.831), alpha: CGFloat(1.0)).CGColor
        quadTwoButton.layer.borderWidth = CGFloat(1.0)
        quadThreeButton.layer.borderColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.784), blue: CGFloat(0.831), alpha: CGFloat(1.0)).CGColor
        quadThreeButton.layer.borderWidth = CGFloat(1.0)
        quadFourButton.layer.borderColor = UIColor(red: CGFloat(0.388), green: CGFloat(0.784), blue: CGFloat(0.831), alpha: CGFloat(1.0)).CGColor
        quadFourButton.layer.borderWidth = CGFloat(1.0)
        
        populateMocTaskList()
        filterTaskList(1)
        categoryLabel.text = matrixCategories[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Matrix Category Action Button Method
    @IBAction func handleSelectCategory(sender: UIButton) {
        
        let selectedCategory = sender 
        
        switch selectedCategory.tag {
        case 1...4:
            filterTaskList(selectedCategory.tag)
            categoryLabel.text = matrixCategories[selectedCategory.tag - 1]
        default:
            filterTaskList(1)
        }
    }
    
    // MARK: UICollectionDelegate and UICollectionViewDataSource Methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfCategories = 1
        
        if matrixCategories.count > 0 {
            numberOfCategories = matrixCategories.count
        }
        return numberOfCategories
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let categoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("matrixCategoryCellID", forIndexPath: indexPath) as! MatrixCategoryCellView
        
        let category = matrixCategories[indexPath.row]
        
      //  categoryCell.category.text = category
        
     //   let temp = categoryCell.category.frame.size.width
        
        categoryCell.configureCell(indexPath.row,forCategory: category)
                
        return categoryCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let priority = indexPath.row + 1
        
        filterTaskList(priority)
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
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
        
        var cellHeight:CGFloat = 44.0
        
        cellHeight += calculateHeightAtIndexPath(indexPath);
        
        return cellHeight;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCellWithIdentifier("TaskListCellViewID", forIndexPath: indexPath) as! TaskListCellView
        
        taskCell.taskDescription.text = taskList[indexPath.row].summary
        taskCell.item = indexPath.row
        taskCell.taskSelected = taskList[indexPath.row].completed
        taskCell.delegate = self
        
        return taskCell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit", handler:{action, indexpath in
          //  toDoTask = taskList[indexPath.row]
              self.performSegueWithIdentifier("NewItem", sender: self)
        });
        
        editRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            //  self.toDoTask = taskList[indexPath.row]
            
            //taskDataAccess.deleteTask(forId self.toDoTask?.taskId?.intValue)
        });
        
        return [deleteRowAction, editRowAction];
    }
    
    func calculateHeightAtIndexPath(indexPath: NSIndexPath)-> CGFloat {
    
        var heightValue:CGFloat   = 1.0;
        let fontSizeValue:CGFloat = 15.0;
        
        let taskDescription = taskList[indexPath.row].summary as NSString
        
        let rect:CGRect = taskDescription.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width, CGFloat.max), options:.UsesLineFragmentOrigin, attributes:[NSFontAttributeName:UIFont.systemFontOfSize(fontSizeValue)], context: nil)
            
        heightValue = rect.size.height;
    
        return heightValue;
    }
    
    func populateMocTaskList()-> Void {
        
        // Priority 1
        let task1 = MocTask()
        task1.completed = false
        task1.priority = 1
        task1.summary = "In a storyboard-based application, you will often want to do"
        
        mocTaskList.append(task1)
        
        let task2 = MocTask()
        task2.completed = false
        task2.priority = 1
        task2.summary = "In a storyboard-based application"
        
        mocTaskList.append(task2)
        
        let task3 = MocTask()
        task3.completed = false
        task3.priority = 1
        task3.summary = "Pass the selected object"
        
        mocTaskList.append(task3)
        
        //Priority 2
        let task4 = MocTask()
        task4.completed = false
        task4.priority = 2
        task4.summary = "UIStoryboardSegue, sender:"
        
        mocTaskList.append(task4)
        
        let task5 = MocTask()
        task5.completed = false
        task5.priority = 2
        task5.summary = "Get the new view controller"
        
        mocTaskList.append(task5)
        //Priority 3
        let task6 = MocTask()
        task6.completed = false
        task6.priority = 3
        task6.summary = "new view controller using segue"
        
        mocTaskList.append(task6)
        
        let task7 = MocTask()
        task7.completed = false
        task7.priority = 3
        task7.summary = "Pass the selected object"
        
        mocTaskList.append(task7)
        
        //Priority 4
        let task8 = MocTask()
        task8.completed = false
        task8.priority = 4
        task8.summary = "a little preparation before navigation"
        
        mocTaskList.append(task8)
        
        let task9 = MocTask()
        task9.completed = false
        task9.priority = 4
        task9.summary = "override func prepareForSegue"
        
        mocTaskList.append(task9)
    }
    
    func filterTaskList(priority: Int)-> Void {
        
       taskList.removeAll()
        
        for task in mocTaskList {
            
            if task.priority == priority {
                taskList.append(task)
            }
        }
        
        taskListTableView.reloadData()
    }
    
    // MARK: - TaskCompleted methods
    func markTaskAsCompleted(isCompleted: Bool, selectItem: Int) {
      
        let selectedTask = taskList[selectItem]
        selectedTask.completed = isCompleted
        //  self.toDoTask = taskList[selectItem]
        //taskDataAccess.setTaskAsCompleted(isCompleted, forId:self.toDoTask?.taskId?.intValue)
    }
    
    // MARK: - prepareForSegue Method
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "NewItem" {
            
            let editTask = segue.destinationViewController as! NewTaskViewController
            editTask.initializeViewController(toEdit: toDoTask!)
        }
    }
}

class MocTask {
    var summary  = ""
    var priority = 4
    var completed = false
}
