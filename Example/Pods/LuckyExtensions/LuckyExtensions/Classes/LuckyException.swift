//
//  LuckyError.swift
//  LuckyExtensions
//
//  Created by junky on 2024/2/23.
//

import Foundation

public enum LuckyException: Error {
    case msg(String)
    case error(Error)
    
    public var localizedDescription: String? {
        switch self {
        case .msg(let string):
            return string
        case .error(let error):
            return error.localizedDescription
        }
    }
    
}




