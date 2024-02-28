//
//  WidgetInfo.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import Foundation


class WidgetInfo: Codable {
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var rotate: CGFloat = 0
    var scale: CGFloat = 1
    
    var txtInfo: Txt? = nil
    var imgInfo: Img? = nil
    var subList: [WidgetInfo] = []
}

