//
//  ViewController.swift
//  LuckyUI
//
//  Created by junky on 2024/2/23.
//

import UIKit
import LuckyExtensions
import Combine
import SnapKit

open class ViewController: UIViewController {

    
    open var navigationBar: NavigationBar = NavigationBar.loadFromXib()
    
    open var cancellables: Set<AnyCancellable> = []
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindVM()
    }

    open func setupUI() {
        
        navigationBar.isHidden = navigationController == nil
        let topMargin: CGFloat = navigationController == nil ? 0 : 44;
        additionalSafeAreaInsets = UIEdgeInsets(top: topMargin, left: 0, bottom: 0, right: 0)
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(view.snp.topMargin)
        }
        
        
    }
    
    open func bindVM() {
        navigationBar.backBtn.publisher(events: .touchUpInside).sinkOnMain { [weak self] _ in
            guard let weakself = self else { return }
            weakself.navigationController?.popViewController(animated: true)
        }.store(in: &cancellables)
    }

}
