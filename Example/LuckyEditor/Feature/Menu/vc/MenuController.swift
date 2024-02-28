//
//  MenuController.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Combine
import LuckyEditor
import LuckyUI

class MenuController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var vm: MenuVM
    
    init(title: String) {
        self.vm = MenuVM(title: title)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func setupUI() {
        super.setupUI()
        tableView.register(UINib(nibName: "SimpleTableCell", bundle: nibBundle), forCellReuseIdentifier: "SimpleTableCell")
    }
    
    override func bindVM() {
        super.bindVM()
        vm.$title.sink { [weak self] title in
            guard let weakself = self else { return }
            weakself.navigationBar.title = title
        }.store(in: &cancellables)
        
        vm.$menuList.sink { [weak self] _ in
            guard let weakself = self else { return }
            weakself.tableView.reloadData()
        }.store(in: &cancellables)
        
        vm.$selectedTitle.sink { [weak self] title in
            guard let weakself = self else { return }
//            "UILabel", "UITextField", "UITextView"
            if weakself.vm.title == "文本" {
                var type = TxtVM.TxtType.label
                if title == "UITextField" {
                    type = .textField
                }
                if title == "UITextView" {
                    type = .textView
                }
                let txt = "hello world 你哦啊时间段爱上地阿斯德哦笑死掉后阿苏好的i哦啊好滴哦啊疏导i哦啊好的及哦啊是的话爱护嗲好滴熬好死哦哈迪啊疏导爱上"
                weakself.navigationController?.pushViewController(TxtController(txt: txt, type: type), animated: true)
            }
            
            if weakself.vm.title == "图片" {
                var type = CodableImage.ImageType.name
                if title == "Disk" {
                    type = .file
                }
                if title == "Remote" {
                    type = .url
                }
                weakself.navigationController?.pushViewController(ImgController(type: type), animated: true)
            }
            if weakself.vm.title == "编辑器" {
                if title == "文本编辑器" {
//                    weakself.navigationController?.pushViewController(TxtEditorController(), animated: true)
                }
            }
            
        }.store(in: &cancellables)
        
    }
    
    
}


extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
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
