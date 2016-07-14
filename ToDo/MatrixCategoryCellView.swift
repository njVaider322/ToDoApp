//
//  MatrixCategoryCellView.swift
//  ToDo
//
//  Created by Nate Jackson on 7/14/16.
//  Copyright © 2016 Nate Jackson. All rights reserved.
//

import UIKit

class MatrixCategoryCellView: UICollectionViewCell {
    
    @IBOutlet weak var backArrow:    UIImageView!
    @IBOutlet weak var forwardArrow: UIImageView!
    @IBOutlet weak var category:     UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        category.text = ""
    }

    func configureCell(index: Int, forCategory categoryValue:String)-> Void {
        
        switch index {
        case 0:
            backArrow.hidden = true
            category.text    = categoryValue
        case 1:
            category.text = categoryValue
        case 2:
            category.text = categoryValue
        case 3:
            forwardArrow.hidden = true
            category.text       = categoryValue
        default:
            backArrow.hidden    = true
            forwardArrow.hidden = true
            category.text       = "No Category"
        }
    }
}
