//
//  ImgController.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LuckyEditor
import Combine
import LuckyUI

class ImgController: ViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var vm: ImgVM
    
    init(type: CodableImage.ImageType = .name) {
        self.vm = ImgVM(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func setupUI() {
        super.setupUI()
        tableView.register(UINib(nibName: "PickerTableCell", bundle: nibBundle), forCellReuseIdentifier: "PickerTableCell")
    }

    override func bindVM() {
        super.bindVM()
        vm.$editItems.sink { [weak self] _ in
            guard let weakself = self else { return }
            weakself.tableView.reloadData()
        }.store(in: &cancellables)
        
        vm.$model.sink { [weak self] cimg in
            guard let weakself = self else { return }
            weakself.imgView.reload(model: cimg)
        }.store(in: &cancellables)
    }
    
}


extension ImgController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.editItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.editItems[indexPath.row]
        var cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        guard let pCell = tableView.dequeueReusableCell(withIdentifier: "PickerTableCell", for: indexPath) as? PickerTableCell else { return cell }
        pCell.nameLab.text = item.title
        pCell.value = (item.value) as? String ?? ""
        cell = pCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vm.didChange(indexpath: indexPath)
    }
}
