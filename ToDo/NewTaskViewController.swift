//
//  NewTaskViewController.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var newTaskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("ImportantCellID", forIndexPath: indexPath) as! ImportantCellView
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("UrgentCellID", forIndexPath: indexPath) as! UrgentCellView
        default:
            cell = UITableViewCell()
        }
        
        return cell!
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
