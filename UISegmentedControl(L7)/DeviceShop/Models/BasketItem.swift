//
//  BasketItem.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 29.09.2023.
//

import Foundation

class BasketItem: Equatable {

    let item: ShopItem
    let count: Int
    let totalPrice: Int
    
    init(item: ShopItem, count: Int, totalPrice: Int) {
        self.item = item
        self.count = count
        self.totalPrice = totalPrice
    }
    
    static func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
        lhs.item.name == rhs.item.name
    }
    
}
