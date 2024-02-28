//
//  CodableColor.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import Foundation

public class CodableColor: Codable {
    
    
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat
    
    public init(color: UIColor) {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    public var color: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
}
