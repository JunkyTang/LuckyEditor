//
//  ImgVM.swift
//  LuckyEditor_Example
//
//  Created by junky on 2024/2/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import LuckyEditor
import SDWebImage

class ImgVM: BaseVM {

    init(type: CodableImage.ImageType) {
        
        switch type {
        case .name:
            editItems = [
                EditInfo(type: .picker, title: "image1", value: "111"),
                EditInfo(type: .picker, title: "image2", value: "222"),
                EditInfo(type: .picker, title: "image3", value: "333"),
                EditInfo(type: .picker, title: "clear", value: ""),
                EditInfo(type: .picker, title: "log", value: "")
            ]
        case .file:
            editItems = [
                EditInfo(type: .picker, title: "image1", value: ""),
                EditInfo(type: .picker, title: "image2", value: ""),
                EditInfo(type: .picker, title: "image3", value: ""),
                EditInfo(type: .picker, title: "clear", value: ""),
                EditInfo(type: .picker, title: "log", value: "")
            ]
        case .url:
            editItems = [
//                EditInfo(type: .picker, title: "image1", value: "https://video.kts.g.mi.com/ktv_1095733246_NUhIVHZRVkl3bGlESHh3Nml4b01zQT09_1650626656602.jpg"),
                EditInfo(type: .picker, title: "image1", value: "aaa.jpg"),
                EditInfo(type: .picker, title: "image2", value: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fd6173090-ee5c-4b2b-b19e-e2953acfe3e9%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1711616661&t=eaffb6c21a26a5a01cf7f82c0cdd6bd1"),
                EditInfo(type: .picker, title: "image3", value: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F4ab7e6f9-7240-4bde-a021-e978d722026c%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1711616661&t=f423cfc649a8127199bc6ba8c66d2557"),
                EditInfo(type: .picker, title: "clear", value: ""),
                EditInfo(type: .picker, title: "log", value: "")
            ]
        }
        super.init()
        let name = (editItems[0].value as? String) ?? ""
        self.model = CodableImage(type: type, name: name)
    }
    
    
    // MARK: - vm -> view
    @CurrentValueSubjectProperty
    var model: CodableImage = CodableImage(type: .name, name: "")
    
    @CurrentValueSubjectProperty
    var editItems: [EditInfo]
    
    
    // MARK: - view -> vm
    func didChange(indexpath: IndexPath) {
        
        
        if indexpath.row == 3 {
            SDImageCache.shared.clearMemory()
            SDImageCache.shared.clearDisk()
            return
        }
        if indexpath.row == 4 {
            guard let json = try? JSONEncoder().encode(model) else { return }
            guard let jsonStr = try? JSONSerialization.jsonObject(with: json, options: JSONSerialization.ReadingOptions.mutableLeaves) else { return }
            print(jsonStr)
            return
        }
        model.name = (editItems[indexpath.row].value as? String) ?? ""
        model.loadImage().sink { compelete in
            if case .failure(let err) = compelete {
                print(err.localizedDescription)
            }
        } receiveValue: { [weak self] image in
            guard let weakself = self else { return }
            weakself.$model.send(weakself.model)
        }.store(in: &cancellables)
    }
    
    
}
