//
//  PopMask.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import UIKit

public class PopMask: UIView {
    
    var didTapSelfCallback: () -> Void = {
        
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        tap.delegate = self
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    @objc public func didTapSelf() {
        didTapSelfCallback()
    }
    

}

extension PopMask: XibLoadable {}

extension PopMask: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: self)
        
        for subV in subviews {
            if subV.frame.contains(touchLocation) {
                return false
            }
        }
        return true
    }
    
}
