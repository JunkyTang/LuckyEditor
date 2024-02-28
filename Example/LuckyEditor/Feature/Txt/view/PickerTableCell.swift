//
//  PickerTableCell.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class PickerTableCell: UITableViewCell {

    
    @IBOutlet weak var nameLab: UILabel!
    
    
    @IBOutlet weak var valueLab: UILabel!
    
    
    var idxPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var value: String = "" {
        didSet {
            valueLab.text = value
        }
    }
    
    var didChangeValue: (String, IndexPath) -> Void = { _, _ in
        
    }
}
