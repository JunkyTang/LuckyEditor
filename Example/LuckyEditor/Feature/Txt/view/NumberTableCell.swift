//
//  NumberTableCell.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class NumberTableCell: UITableViewCell {

    
    @IBOutlet weak var nameLab: UILabel!
    
    
    @IBOutlet weak var numberLab: UILabel!
    
    
    @IBAction func actionForRed(_ sender: UIButton) {
        number -= 1
        didChangeNumber(number, indexPath)
    }
    
    
    @IBAction func actionForAdd(_ sender: UIButton) {
        number += 1
        didChangeNumber(number, indexPath)
    }
    
    
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var number: Int = 0 {
        didSet {
            numberLab.text = "\(number)"
        }
    }
    var didChangeNumber:(Int, IndexPath) -> Void = { _, _ in
        
    }
    
    
    
    
    
    
    
    
}
