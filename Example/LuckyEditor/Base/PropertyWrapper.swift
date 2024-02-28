//
//  wrapper.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Combine



@propertyWrapper
public struct CurrentValueSubjectProperty<T> {
    
    public var wrappedValue: T {
        didSet {
            projectedValue.send(wrappedValue)
        }
    }
    
    public var projectedValue: CurrentValueSubject<T, Never>
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.projectedValue = CurrentValueSubject(wrappedValue)
    }
    
}


@propertyWrapper
public struct PassthroughSubjectProperty<T> {
    
    public var wrappedValue: T {
        didSet {
            projectedValue.send(wrappedValue)
        }
    }
    
    public var projectedValue = PassthroughSubject<T, Never>()
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
}


