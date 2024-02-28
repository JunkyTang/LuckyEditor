//
//  PopPosition.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import Foundation

public enum PopPosition {

    /// 横向位置
    public enum LateralPosition {
        case left(padding: CGFloat)
        case center(padding: CGFloat)
        case right(padding: CGFloat)
        case fill(padding: CGFloat)
    }
    
    /// 纵向位置
    public enum LongitudinalPosition {
        case top(padding: CGFloat)
        case center(padding: CGFloat)
        case bottom(padding: CGFloat)
        case fill(padding: CGFloat)
    }
    
    
    case inScreen(lateral: LateralPosition, longitudinal: LongitudinalPosition)
    case outScreen(lateral: LateralPosition, longitudinal: LongitudinalPosition)
    
}
