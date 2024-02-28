//
//  Txt.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import UIKit


public class Txt: Codable {
    
    
    public var text: String = ""
    
    public var font: CodableFont = CodableFont()
    
    public var hassUnderline: Bool = false
    
    public var lineSpace: CGFloat = 0
    
    public var worldSpace: CGFloat = 0
    
    public var alignment: NSTextAlignment = .center
    
    public var foregroundColor: CodableColor = CodableColor(color: .black)
    
    public var backgroundColor: CodableColor = CodableColor(color: .clear)
    
    
    public init(text: String = "", font: CodableFont = CodableFont(), hassUnderline: Bool = false, lineSpace: CGFloat = 0, worldSpace: CGFloat = 0, alignment: NSTextAlignment = .left, foregroundColor: CodableColor = CodableColor(color: .black), backgroundColor: CodableColor = CodableColor(color: .clear)) {
        self.text = text
        self.font = font
        self.hassUnderline = hassUnderline
        self.lineSpace = lineSpace
        self.worldSpace = worldSpace
        self.alignment = alignment
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    
    public var attributes: [NSAttributedString.Key: Any] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font.font(),
            .paragraphStyle: paragraphStyle,
            .kern : worldSpace,
            .foregroundColor: foregroundColor.color,
            .backgroundColor: backgroundColor.color
        ]
        
        if hassUnderline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        return attributes
    }
    
    public var attributeString: NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}

extension NSTextAlignment: Codable {}






