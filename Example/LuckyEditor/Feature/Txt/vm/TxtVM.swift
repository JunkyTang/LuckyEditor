//
//  TxtVM.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LuckyEditor





class TxtVM: BaseVM {

    enum TxtType {
        
        case label
        case textField
        case textView
    }
    
    init(type: TxtType, model: Txt) {
        self.type = type
        self.model = model
    }
    
    
    // MARK: - vm -> view
    
    @CurrentValueSubjectProperty
    var type: TxtType = .label
    
    @CurrentValueSubjectProperty
    var model: Txt = Txt()
    
    @CurrentValueSubjectProperty
    var editItems: [EditInfo] = [
        EditInfo(type: .swch, title: "字体", value: true),
        EditInfo(type: .swch, title: "粗体", value: false),
        EditInfo(type: .swch, title: "斜体", value: false),
        EditInfo(type: .swch, title: "下划线", value: false),
        EditInfo(type: .number, title: "大小", value: 20),
        EditInfo(type: .number, title: "字间距", value: 0),
        EditInfo(type: .number, title: "行间距", value: 0),
        EditInfo(type: .number, title: "对齐", value: 0),
        EditInfo(type: .swch, title: "颜色", value: false),
        EditInfo(type: .swch, title: "背景色", value: false),
        EditInfo(type: .picker, title: "log", value: "")
    ]
    
    
    // MARK: - view -> vm
    
    func didChangeValue(value: Any, indexpath: IndexPath) {
        
        if indexpath.row == 0 {
            guard let isOn = value as? Bool else { return }
            model.font.url = isOn ? nil : Bundle.main.url(forResource: "STCAIYUN", withExtension: "TTF")
        }
        if indexpath.row == 1 {
            guard let isOn = value as? Bool else { return }
            model.font.isBold = isOn
        }
        if indexpath.row == 2 {
            guard let isOn = value as? Bool else { return }
            model.font.isItalic = isOn
        }
        if indexpath.row == 3 {
            guard let isOn = value as? Bool else { return }
            model.hassUnderline = isOn
        }
        if indexpath.row == 4 {
            guard let size = value as? Int else { return }
            model.font.size = CGFloat(size)
        }
        if indexpath.row == 5 {
            guard let size = value as? Int else { return }
            model.worldSpace = CGFloat(size)
        }
        if indexpath.row == 6 {
            guard let size = value as? Int else { return }
            model.lineSpace = CGFloat(size)
        }
        if indexpath.row == 7 {
            guard let size = value as? Int else { return }
            if let align = NSTextAlignment(rawValue: size) {
                model.alignment = align
            }
        }
        if indexpath.row == 8 {
            guard let isOn = value as? Bool else { return }
            model.foregroundColor = isOn ? CodableColor(color: .white) : CodableColor(color: .black)
        }
        if indexpath.row == 9 {
            guard let isOn = value as? Bool else { return }
            model.backgroundColor = isOn ? CodableColor(color: .black) : CodableColor(color: .white)
        }
        if indexpath.row == 10 {
            guard let json = try? JSONEncoder().encode(model) else { return }
            guard let jsonStr = try? JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.mutableContainers) else { return }
            print(jsonStr)
            return
        }
        
        $model.send(model)
    }
    
}
