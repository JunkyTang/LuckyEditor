//
//  Array+Ex.swift
//  LuckyExtensions
//
//  Created by junky on 2024/2/23.
//

import Foundation

public extension Array {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
