//
//  TaskListCellView.swift
//  ToDo
//
//  Created by Nate Jackson on 7/14/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

protocol TaskCompleted {
    func markTaskAsCompleted(isCompleted: Bool, selectItem: Int)
}

class TaskListCellView: UITableViewCell {
    
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskComplete: UIButton!
    
    var delegate: TaskCompleted?
    private var itemSelected = false
    var item         = 0
    var taskSelected: Bool {
        
        get {
            return itemSelected
        }
        set(value) {
            itemSelected = value
            updateButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskDescription.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleTaskComplete(sender: UIButton) {
       
        itemSelected = !itemSelected
        
        updateButton()
        
    }
    
    func updateButton()->Void {
        
        let newImage = UIImage(named: itemSelected ? "com_check_selected" : "com_check_default")
        taskComplete.setImage(newImage, forState:.Normal)
        delegate?.markTaskAsCompleted(itemSelected, selectItem: item)
    }

}
