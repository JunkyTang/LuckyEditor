//
//  NavigationBar.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import UIKit
import Combine

open class NavigationBar: UIView {

    
    @IBOutlet open weak var titleLabel: UILabel!
    
    @IBOutlet open weak var leftStackView: UIStackView!
    
    @IBOutlet open weak var rightStackView: UIStackView!
    
    @IBOutlet open weak var backBtn: UIButton!
    
    
    open var title: String {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text ?? ""
        }
    }
    
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    
}


extension NavigationBar: XibLoadable {}
