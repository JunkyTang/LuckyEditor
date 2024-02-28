//
//  CodableImage.swift
//  LuckyEditor
//
//  Created by junky on 2024/2/27.
//

import UIKit
import Combine
import SDWebImage
import LuckyExtensions

public class CodableImage: Codable {
    
    
    public enum ImageType: Codable {
        case name
        case file
        case url
    }
    
    public var type: ImageType
    
    public var name: String
    
    public init(type: ImageType, name: String) {
        self.type = type
        self.name = name
    }
    
    public func loadImage() -> Future<UIImage, Error> {
        return Future<UIImage, Error> { promise in
            
            if let img = SDImageCache.shared.imageFromCache(forKey: self.name) {
                promise(.success(img))
                return
            }
            
            switch self.type {
            case .name:
                guard let img = UIImage(named: self.name) else {
                    promise(.failure(LuckyException.msg("can load image with name '\(self.name)'")))
                    return
                }
                SDImageCache.shared.store(img, forKey: self.name) {
                    promise(.success(img))
                }
            case .file:
                guard let img = UIImage(contentsOfFile: self.name) else {
                    promise(.failure(LuckyException.msg("can load image with file '\(self.name)'")))
                    return
                }
                SDImageCache.shared.store(img, forKey: self.name) {
                    promise(.success(img))
                }
            case .url:
                SDWebImageDownloader.shared.downloadImage(with: URL(string: self.name)) { [weak self] img, data, err, success in
                    guard let weakself = self else { return }
                    guard let img = img else {
                        promise(.failure(LuckyException.msg("can load image with url '\(weakself.name)'")))
                        return
                    }
                    SDImageCache.shared.store(img, forKey: weakself.name)
                    promise(.success(img))
                }
            }
        }
    }
}




