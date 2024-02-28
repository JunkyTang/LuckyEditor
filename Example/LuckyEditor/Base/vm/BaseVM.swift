//
//  BaseVM.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Combine


class BaseVM {
    
    public var cancellables: Set<AnyCancellable> = []
    
    
    deinit {
        cancellables.forEach{ $0.cancel() }
    }
    
}

