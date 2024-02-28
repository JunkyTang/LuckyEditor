//
//  NavigationController.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import UIKit

open class NavigationController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
    }


    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if let vc = viewController as? ViewController {
            if viewControllers.count > 0 {
                vc.hidesBottomBarWhenPushed = true
                if let vc = viewController as? ViewController {
                    vc.navigationBar.backBtn.isHidden = false
                }
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    

}
