//
//  SwitchTableCell.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class SwitchTableCell: UITableViewCell {

    
    @IBOutlet weak var nameLab: UILabel!
    
    
    @IBOutlet weak var swch: UISwitch!
    
    @IBAction func actionForSwitch(_ sender: UISwitch) {
        isOn = sender.isOn
        didChangeSwitch(isOn, indexPath)
    }
    
    
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    var isOn: Bool = false {
        didSet {
            swch.isOn = isOn
        }
    }
    
    var didChangeSwitch: (Bool, IndexPath) -> Void = { _, _ in
        
    }
    
    
    
    
    
}
