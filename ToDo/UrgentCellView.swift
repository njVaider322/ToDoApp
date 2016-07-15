//
//  UrgentCellView.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

class UrgentCellView: UITableViewCell {
    
    @IBOutlet weak var isUrgentButton: UIButton!
    @IBOutlet weak var notUrgentButton: UIButton!
    
    var isUrgent = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func handleTaskUrgentSelection(sender: UIButton) {
        
    }
}
