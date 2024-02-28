//
//  Popable.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import Foundation
import UIKit

public protocol Popable {
    
    var containerView: UIView { get }
    
    var needMask: Bool { get }
    
    var animation: PopAnimation { get }
    
    func didTapMask()
}

public extension Popable {
    
    var needMask: Bool {
        return true
    }
    
    var animation: PopAnimation {
        return .none(position: .inScreen(lateral: .fill(padding: -20), longitudinal: .center(padding: 0)))
    }
    
    func didTapMask() {
        hide(nil)
    }
    
    func show(_ inView: UIView? = nil) {
        
        var superView = inView
        if superView == nil {
            guard let delegate = UIApplication.shared.delegate,
                  let window = delegate.window else { return }
            superView = window
        }
        
        if needMask {
            
            let mask = PopMask.loadFromXib()
            mask.didTapSelfCallback = didTapMask
            superView?.addSubview(mask)
            mask.snp.makeConstraints { make in
                make.edges.equalTo(0)
            }
            superView = mask
        }
        
        guard let superView = superView else { return }
        superView.addSubview(containerView)
        animation.fromPosition(containerView)
        superView.layoutIfNeeded()
        UIView.animate(withDuration: 0.8) {
            animation.toPosition(containerView)
        }
        
    }
    
    func hide(_ compelete: (() -> Void)?) {

        var viewForRemove: UIView = containerView
        if needMask {
            guard let superView = containerView.superview else { return }
            viewForRemove = superView
        }
        
        
        switch animation {
        case .none(_):
            viewForRemove.removeFromSuperview()
        case .move(_, _):
            UIView.animate(withDuration: 0.5) {
                containerView.transform = CGAffineTransform.identity
            } completion: { finish in
                viewForRemove.removeFromSuperview()
                compelete?()
            }

        case .scale(_, _):
            UIView.animate(withDuration: 0.5) {
                containerView.transform = CGAffineTransform.identity
            } completion: { finish in
                viewForRemove.removeFromSuperview()
                compelete?()
            }
        }
        
    }
    
    
    
}

public extension Popable where Self: UIView {
    
    var containerView: UIView {
        return self
    }
    
}


