//
//  EditInfo.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

class EditInfo {
    
    enum editType {
        case swch
        case picker
        case number
    }
    
    var type: editType = .swch
    
    var title: String = ""
    
    var value: Any = 0
    
    init(type: editType, title: String, value: Any) {
        self.type = type
        self.title = title
        self.value = value
    }
    
    
}
