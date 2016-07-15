//
//  ImportantCellView.swift
//  ToDo
//
//  Created by Nate Jackson on 7/15/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

protocol ImportantCellDelegate {
    func didMakeImportantCellSelection(selectedValue: Bool)
}

class ImportantCellView: UITableViewCell {
    
    @IBOutlet weak var isImportantButton: UIButton!
    @IBOutlet weak var notImportantButton: UIButton!
    
    var delegate: ImportantCellDelegate?
    var isImportant = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleTaskImportantSelection(sender: UIButton) {
        
        let selectButton = sender
        
        switch selectButton.tag {
        case 1:
            isImportantButton.selected  = true
            notImportantButton.selected = false
            isImportant                 = true
        case 2:
            isImportantButton.selected  = false
            notImportantButton.selected = true
            isImportant                 = false
        default:
            isImportantButton.selected  = false
            notImportantButton.selected = false
        }
        
        delegate?.didMakeImportantCellSelection(isImportant)
    }
}
