//
//  XibLoadable.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import Foundation

public protocol XibLoadable {}

public extension XibLoadable where Self: UIView {
    
    typealias S = Self
    
    static func loadFromXib(name: String? = nil) -> S {
        
        var xibName = name;
        if xibName == nil {
            xibName = String(describing: self)
        }
        
        let bundle = Bundle(for: S.self)
        if let xibName = xibName,
           let instance = bundle.loadNibNamed(xibName, owner: nil)?.first,
           let view = instance as? Self {
            return view
        }
        return S()
    }
}
