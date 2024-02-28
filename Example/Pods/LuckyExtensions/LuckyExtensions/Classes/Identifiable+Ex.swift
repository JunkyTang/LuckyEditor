//
//  Identifiable+Ex.swift
//  LuckyExtensions
//
//  Created by junky on 2024/2/23.
//

import Foundation


extension Identifiable where ID: Equatable, Self: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

