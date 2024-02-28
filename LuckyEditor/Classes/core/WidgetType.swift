//
//  WidgetType.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import UIKit
import SDWebImage

public protocol WidgetType {
    associatedtype Model: Codable;
    
    func reload(model: Model)
    
}


extension UILabel: WidgetType {
    
    public func reload(model: Txt) {
        attributedText = model.attributeString
    }
}

extension UITextField: WidgetType {
    
    public func reload(model: Txt) {
        attributedText = model.attributeString
    }
}

extension UITextView: WidgetType {
    
    public func reload(model: Txt) {
        attributedText = model.attributeString
    }
}

extension UIImageView: WidgetType {
    
    public func reload(model: CodableImage) {
        image = SDImageCache.shared.imageFromCache(forKey: model.name)
    }
}






