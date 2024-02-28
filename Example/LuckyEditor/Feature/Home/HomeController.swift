//
//  HomeController.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LuckyUI
import Combine

class HomeController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vm: HomeVM = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func setupUI() {
        super.setupUI()
        navigationBar.title = "HOME"
        tableView.register(UINib(nibName: "SimpleTableCell", bundle: nibBundle), forCellReuseIdentifier: "SimpleTableCell")
    }

    override func bindVM() {
        super.bindVM()
        vm.$menuList.sink { [weak self] list in
            guard let weakself = self else { return }
            weakself.tableView.reloadData()
        }.store(in: &cancellables)
            
        vm.$selectedTitle.sink { [weak self] title in
            guard let weakself = self,
                let title = title else { return }
            weakself.navigationController?.pushViewController(MenuController(title: title), animated: true)
        }.store(in: &cancellables)
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableCell") as? SimpleTableCell else { return UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell") }
        
        cell.titleLab.text = vm.menuList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        vm.didSelected(indexPath)
    }
    
    
}

