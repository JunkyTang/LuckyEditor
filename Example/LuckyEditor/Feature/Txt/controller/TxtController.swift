//
//  TxtController.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import Combine
import LuckyEditor
import LuckyUI

class TxtController: ViewController {

    
    
    @IBOutlet weak var editorContainer: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var widgetView: UIView = UILabel()
    
    
    
    var vm: TxtVM
    
    init(txt: String, type: TxtVM.TxtType = .label) {
        self.vm = TxtVM(type: type, model: Txt(text: txt))
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
        tableView.register(UINib(nibName: "SwitchTableCell", bundle: nibBundle), forCellReuseIdentifier: "SwitchTableCell")
        tableView.register(UINib(nibName: "PickerTableCell", bundle: nibBundle), forCellReuseIdentifier: "PickerTableCell")
        tableView.register(UINib(nibName: "NumberTableCell", bundle: nibBundle), forCellReuseIdentifier: "NumberTableCell")
        
    }
    
    override func bindVM() {
        super.bindVM()
        vm.$editItems.sink { [weak self] _ in
            guard let weakself = self else { return }
            weakself.tableView.reloadData()
        }.store(in: &cancellables)
        
        
        vm.$type.sink { [weak self] type in
            guard let weakself = self else { return }
            
            switch type {
            case .label:
                let tmp = UILabel()
                tmp.numberOfLines = 0
                tmp.reload(model: weakself.vm.model)
                weakself.widgetView = tmp
            case .textField:
                let tmp = UITextField()
                tmp.reload(model: weakself.vm.model)
                weakself.widgetView = tmp
            case .textView:
                let tmp = UITextView()
                tmp.reload(model: weakself.vm.model)
                weakself.widgetView = tmp
            }
            weakself.editorContainer.subviews.forEach{$0.removeFromSuperview()}
            weakself.editorContainer.addSubview(weakself.widgetView)
            weakself.widgetView.frame = weakself.editorContainer.bounds
        }.store(in: &cancellables)
        
        
        vm.$model.sink { [weak self] txt in
            guard let weakself = self else { return }
            print("-----")
            if let label = weakself.widgetView as? UILabel {
                label.reload(model: txt)
            }
            
            if let label = weakself.widgetView as? UITextField {
                label.reload(model: txt)
            }
            
            if let label = weakself.widgetView as? UITextView {
                label.reload(model: txt)
            }
        }.store(in: &cancellables)
        
    }

}



extension TxtController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.editItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = vm.editItems[indexPath.row]
        var cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        switch item.type {
        case .number:
            guard let nCell = tableView.dequeueReusableCell(withIdentifier: "NumberTableCell", for: indexPath) as? NumberTableCell else { return cell }
            nCell.indexPath = indexPath
            nCell.didChangeNumber = { number, idxPath in
                self.vm.didChangeValue(value: number, indexpath: idxPath)
            }
            nCell.nameLab.text = item.title
            nCell.number = (item.value as? Int) ?? 0
            cell = nCell
        case .picker:
            guard let pCell = tableView.dequeueReusableCell(withIdentifier: "PickerTableCell", for: indexPath) as? PickerTableCell else { return cell }
            pCell.nameLab.text = item.title
            pCell.value = (item.value as? String) ?? "0"
            cell = pCell
        case .swch:
            guard let sCell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableCell", for: indexPath) as? SwitchTableCell else { return cell }
            sCell.indexPath = indexPath
            sCell.didChangeSwitch = { value, idxPath in
                self.vm.didChangeValue(value: value, indexpath: idxPath)
            }
            sCell.nameLab.text = item.title
            sCell.isOn = (item.value as? Bool) ?? false
            cell = sCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 10 {
            vm.didChangeValue(value: "", indexpath: indexPath)
        }
    }
}
