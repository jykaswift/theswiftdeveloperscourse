//
//  Device.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 27.09.2023.
//

import Foundation


protocol Imageble {
    var imagesNames: [String]? { get  set}
    
    mutating func addImageBy(name: String)
}

extension Imageble {
    mutating func addImageBy(name: String) {
        if imagesNames != nil {
            imagesNames!.append(name)
        } else {
            imagesNames = [name]
        }
    }
}

protocol ShopItem: Imageble {
    var name: String { get }
    var price: Int { get }
    var description: String { get }
    var mainImageName: String { get }
}

extension ShopItem {
    var mainImageName: String {
        if let imagesNames, !imagesNames.isEmpty {
            return imagesNames.first!
        } else {
            return "image_not_available"
        }
    }
}


class Device: ShopItem {
    var imagesNames: [String]?
    
    var characteristics = [String: String]()
    
    var name: String
    
    var price: Int
    
    var description: String
    
    init(name: String, price: Int, description: String) {
        self.name = name
        self.price = price
        self.description = description
    }
    
    
}
