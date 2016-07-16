//
//  UrgentCellView.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

protocol UrgentCellDelegate {
    func didMakeUrgentCellSelection(selectedValue: Bool)
}

class UrgentCellView: UITableViewCell {
    
    @IBOutlet weak var isUrgentButton: UIButton!
    @IBOutlet weak var notUrgentButton: UIButton!
    
    var delegate: UrgentCellDelegate?
    var isUrgent = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleTaskUrgentSelection(sender: UIButton) {
        let selectButton = sender
        
        switch selectButton.tag {
        case 1:
            isUrgentButton.selected  = true
            notUrgentButton.selected = false
            isUrgent                 = true
        case 2:
            isUrgentButton.selected  = false
            notUrgentButton.selected = true
            isUrgent                 = false
        default:
            isUrgentButton.selected  = false
            notUrgentButton.selected = false
        }
        
        delegate?.didMakeUrgentCellSelection(isUrgent)
    }
    
    func setButtonStatesForPriority(priority:Int)-> Void {
        
        switch priority {
        case 1:
            isUrgentButton.selected  = true
            notUrgentButton.selected = false
            isUrgent                 = true
        case 2:
            isUrgentButton.selected  = false
            notUrgentButton.selected = true
            isUrgent                 = false
        case 3:
            isUrgentButton.selected  = true
            notUrgentButton.selected = false
            isUrgent                 = true
        case 4:
            isUrgentButton.selected  = false
            notUrgentButton.selected = true
            isUrgent                 = false
        default:
            isUrgentButton.selected  = false
            notUrgentButton.selected = false
            isUrgent                 = false
        }
    }
}
