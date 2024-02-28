//
//  HomeVM.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Combine

class HomeVM: BaseVM {

    
    // MARK: - vm -> view
    @CurrentValueSubjectProperty
    var menuList: [String] = ["文本", "图片", "编辑器"]
    
    @PassthroughSubjectProperty
    var selectedTitle: String?
    
    
    // MARK: - view -> vm
    
    func didSelected(_ index: IndexPath) {
        selectedTitle = menuList[index.row]
    }
    
    
    
    
}
