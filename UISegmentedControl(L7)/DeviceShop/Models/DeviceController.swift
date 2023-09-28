//
//  deviceController.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 27.09.2023.
//

import Foundation

protocol ShopItemControllerProtocol {
    
    associatedtype Item: ShopItem
    
    var itemList: [Item] { get set }
    
    mutating func addItem(item: Item)
    
}

extension ShopItemControllerProtocol {
    
    mutating func addItem(item: Item) {
        itemList.append(item)
    }
    
}

class ShopItemController<T: ShopItem>: ShopItemControllerProtocol {

    typealias Item = T
    
    var itemList = [T]()
    
}
