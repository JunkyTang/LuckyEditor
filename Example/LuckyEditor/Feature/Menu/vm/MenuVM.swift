//
//  MenuVM.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit

class MenuVM: BaseVM {

    
    
    
    // MARK: - vm -> view
    
    @CurrentValueSubjectProperty
    var title: String = ""
    
    @CurrentValueSubjectProperty
    var menuList: [String] = []
    
    @PassthroughSubjectProperty
    var selectedTitle: String?
    
    
    
    init(title: String) {
        self.title = title
        var menuList: [String] = []
        if title == "文本" {
            menuList = ["UILabel", "UITextField", "UITextView"]
        }
        if title == "图片" {
            menuList = ["Name", "Disk", "Remote"]
        }
        if title == "编辑器" {
            menuList = ["文本编辑器", "图片编辑器"]
        }
        self.menuList = menuList
    }
    
    
    
    // MARK: - view -> vm
    
    func didSelected(_ index: IndexPath) {
        selectedTitle = menuList[index.row]
    }
    
    
    
}
