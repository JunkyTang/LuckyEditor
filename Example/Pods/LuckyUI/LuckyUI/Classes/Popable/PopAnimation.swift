//
//  PopAnimation.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import Foundation
import SnapKit
import UIKit

public enum PopAnimation {
    case none(position: PopPosition)
    case move(from: PopPosition, to: PopPosition)
    case scale(position: PopPosition, to: CGFloat)
    
    
    func fromPosition(_ view: UIView) {
        
        
        var lat = PopPosition.LateralPosition.fill(padding: -40)
        var lon = PopPosition.LongitudinalPosition.fill(padding: -40)
        var pos = PopPosition.inScreen(lateral: lat, longitudinal: lon)
        
        switch self {
        case .none(let position):
            pos = position
        case .move(let from, _):
            pos = from
        case .scale(let position, _):
            pos = position
        }
        
        switch pos {
        case .inScreen(let lateral, let longitudinal):
            lat = lateral
            lon = longitudinal
            view.snp.makeConstraints { make in
                
                switch lat {
                case .left(let padding):
                    make.left.equalTo(padding)
                case .center(let padding):
                    make.centerX.equalTo(view.superview!).offset(padding)
                case .right(let padding):
                    make.right.equalTo(-padding)
                case .fill(let padding):
                    make.centerX.equalTo(view.superview!)
                    make.width.equalTo(view.superview!).offset(padding)
                }
                
                switch lon {
                case .top(let padding):
                    make.top.equalTo(padding)
                case .center(let padding):
                    make.centerY.equalTo(view.superview!).offset(padding)
                case .bottom(let padding):
                    make.bottom.equalTo(-padding)
                case .fill(let padding):
                    make.centerY.equalTo(view.superview!)
                    make.height.equalTo(view.superview!).offset(padding)
                }
            }
        case .outScreen(let lateral, let longitudinal):
            lat = lateral
            lon = longitudinal
            view.snp.makeConstraints { make in
                
                switch lat {
                case .left(let padding):
                    make.right.equalTo(view.snp.left).offset(padding)
                case .center(let padding):
                    make.centerX.equalTo(view.superview!).offset(padding)
                case .right(let padding):
                    make.left.equalTo(view.superview!.snp.right).offset(padding)
                case .fill(let padding):
                    make.centerX.equalTo(view.superview!)
                    make.width.equalTo(view.superview!).offset(padding)
                }
                
                switch lon {
                case .top(let padding):
                    make.bottom.equalTo(view.superview!.snp.top).offset(padding)
                case .center(let padding):
                    make.centerY.equalTo(view.superview!).offset(padding)
                case .bottom(let padding):
                    make.top.equalTo(view.superview!.snp.bottom).offset(padding)
                case .fill(let padding):
                    make.centerY.equalTo(view.superview!)
                    make.height.equalTo(view.superview!).offset(padding)
                }
            }
        }
        
    }
    
    func toPosition(_ view: UIView) {
        
        switch self {
        case .none(let position):
            return
        case .move(_, let to):
            var moveX: CGFloat = 0
            var moveY: CGFloat = 0
            
            switch to {
            case .inScreen(lateral: let lat, longitudinal: let lon):
                switch lat {
                case .left(padding: let padding):
                    moveX = CGRectGetMinX(view.frame) - padding
                case .center(padding: let padding):
                    moveX = CGRectGetMidX(view.frame) - (CGRectGetMidX(view.superview!.bounds) - padding)
                case .right(padding: let padding):
                    moveX = CGRectGetMinX(view.frame) - CGRectGetMaxX(view.superview!.bounds) + padding
                case .fill(padding: let padding):
                    moveX = CGRectGetMinX(view.frame) - padding / 2
                }
                
                switch lon {
                case .top(padding: let padding):
                    moveY = CGRectGetMinY(view.frame) - padding
                case .center(padding: let padding):
                    moveY = CGRectGetMinY(view.frame) - (CGRectGetMidY(view.superview!.bounds) - padding)
                case .bottom(padding: let padding):
                    moveY = CGRectGetMaxY(view.frame) - CGRectGetMaxY(view.superview!.bounds) + padding
                case .fill(padding: let padding):
                    moveY = CGRectGetMinY(view.frame) - padding / 2
                }
                
            case .outScreen(lateral: let lat, longitudinal: let lon):
                
                switch lat {
                case .left(padding: let padding):
                    moveX = CGRectGetMaxX(view.frame) - padding
                case .center(padding: let padding):
                    moveX = CGRectGetMinX(view.frame) - (CGRectGetMidX(view.superview!.bounds) - padding)
                case .right(padding: let padding):
                    moveX = CGRectGetMinX(view.frame) - CGRectGetMaxX(view.superview!.bounds) - padding
                case .fill(padding: let padding):
                    moveX = CGRectGetMaxX(view.frame) - padding / 2
                }
                
                switch lon {
                case .top(padding: let padding):
                    moveY = CGRectGetMaxY(view.frame) - padding
                case .center(padding: let padding):
                    moveY = CGRectGetMinY(view.frame) - (CGRectGetMidY(view.superview!.bounds) - padding)
                case .bottom(padding: let padding):
                    moveY = CGRectGetMinY(view.frame) - CGRectGetMaxX(view.superview!.bounds) - padding
                case .fill(padding: let padding):
                    moveY = CGRectGetMaxY(view.frame) - padding / 2
                }
            }
            view.transform = CGAffineTransformMakeTranslation(-moveX, -moveY)
        case .scale(_, let to):
            view.transform = CGAffineTransformMakeScale(to, to)
        }
    }
    
    
    
    
}

