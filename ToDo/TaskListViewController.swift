//
//  TaskListViewController.swift
//  ToDo
//
//  Created by Nate Jackson on 7/14/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit
import Foundation

class TaskListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var matrixCategoryCollectionView: UICollectionView!
    @IBOutlet weak var taskListTableView: UITableView!
    
    //Collection Stuff
    let matrixCategories = ["IMPORTANT - URGENT","IMPORTANT - NOT URGENT","NOT IMPORTANT - URGENT", "NOT IMPORTANT - NOT URGENT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        
        categoryCell.configureCell(indexPath.row,forCategory: category)
        
        return categoryCell
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK: UITableViewDelegate and UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let taskCell = tableView.dequeueReusableCellWithIdentifier("TaskListCellViewID", forIndexPath: indexPath) as! TaskListCellView
        
        taskCell.taskDescription.text = "Test"
        
        return taskCell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
