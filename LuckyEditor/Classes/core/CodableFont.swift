//
//  CodableFont.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import UIKit
import LuckyExtensions

public class CodableFont: Codable {
    
    public var size: CGFloat = 20
    public var isBold: Bool = false
    public var isItalic: Bool = false
    public var url: URL?
    
    public init(size: CGFloat = 20, isBold: Bool = false, isItalic: Bool = false, url: URL? = nil) {
        self.size = size
        self.isBold = isBold
        self.isItalic = isItalic
        self.url = url
    }
    
    public func font() -> UIFont {
        
        var descriptor = UIFont.systemFont(ofSize: 15).fontDescriptor
        
        if let url = url,
           let name = try? CodableFont.registerFont(url) {
            descriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name : name])
            
        }
        var traits = descriptor.symbolicTraits
        traits = traits.union([.traitBold, .traitItalic])

        if !isBold {
            traits.remove(.traitBold)
        }
        if !isItalic {
            traits.remove(.traitItalic)
        }
        if let tmp = descriptor.withSymbolicTraits(traits) {
            descriptor = tmp
        }
        
        let res = UIFont(descriptor: descriptor, size: size)
        return res
    }
    
    
    public static var registerFont: (URL) throws -> String = { url in
        guard let fontDataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(fontDataProvider),
              let name = font.postScriptName as? String else {
            throw LuckyException.msg("Failed to load font")
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        return name
    }
}


public extension URL {
    
    var nameAndExtension: (String, String)? {
        
        let lastPath = lastPathComponent
        let components = lastPath.components(separatedBy: ".")
        guard components.count > 1 else {
            return nil
        }
        
        let filenameWithoutExtension = components.dropLast().joined(separator: ".")
        let fileExtension = components.last!
        return (filenameWithoutExtension, fileExtension)
    }
}
