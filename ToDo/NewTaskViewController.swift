//
//  NewTaskViewController.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UrgentCellDelegate,ImportantCellDelegate, UITextViewDelegate {
    
    @IBOutlet weak var newTaskTableView: UITableView!
    @IBOutlet weak var cancelBarButton:  UIBarButtonItem!
    @IBOutlet weak var saveBarButton:    UIBarButtonItem!
    
    var taskModel: NewTaskModel?
    var activeTextView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskModel = NewTaskModel()
        let test = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate and UITableViewDataSource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var cellHeight = CGFloat(44)
        
        switch indexPath.row {
        case 0:
            cellHeight = CGFloat(150)
        case 1...2:
            cellHeight = CGFloat(98)
        default:
            cellHeight = CGFloat(44)
        }

        return cellHeight;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCellID", forIndexPath: indexPath) as! DescriptionCellView
            (cell as! DescriptionCellView).descriptionTextView.delegate = self
            activeTextView = (cell as! DescriptionCellView).descriptionTextView
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("ImportantCellID", forIndexPath: indexPath) as! ImportantCellView
            (cell as! ImportantCellView).delegate = self
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("UrgentCellID", forIndexPath: indexPath) as! UrgentCellView
            (cell as! UrgentCellView).delegate = self
        default:
            cell = UITableViewCell()
        }
        
        return cell!
    }
    
    // MARK: ImportantCellDelegate Methods
    func didMakeImportantCellSelection(selectedValue: Bool) {
        
        taskModel?.isImportant = selectedValue
        taskModel?.computeTaskPriority()
    }
    
    // MARK: UrgentCellDelegate Methods
    func didMakeUrgentCellSelection(selectedValue: Bool) {
        
        taskModel?.isUrgent = selectedValue
        taskModel?.computeTaskPriority()
    }
    
    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        /*
         Provide a "Done" button for the user to select to signify completion
         with writing text in the text view.
         */
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action:#selector(NewTaskViewController.doneBarButtonItemClicked) )
        
        navigationItem.setRightBarButtonItem(doneBarButtonItem, animated: true)
    }
    
   /* func textViewDidChange(textView: UITextView) {
        taskModel?.taskDescription = textView.text.characters.count > 0 ? textView.text : ""
        print(taskModel?.taskDescription)
    }*/
    
    // MARK: Bar Button Item Actions Method
    func doneBarButtonItemClicked() {
        
        taskModel?.taskDescription = activeTextView!.text.characters.count > 0 ? activeTextView!.text : ""
        print(taskModel?.taskDescription)
        
        // Dismiss the keyboard by removing it as the first responder.
        activeTextView!.resignFirstResponder()
        
        navigationItem.setRightBarButtonItem(nil, animated: true)
    }
    
    // MARK: - Cancel and Save Action Methods
    @IBAction func cancel(sender:UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender:UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
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
