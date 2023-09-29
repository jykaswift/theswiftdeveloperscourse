//
//  Basket.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 29.09.2023.
//

import Foundation

class Basket {
    
    var itemList = [BasketItem]()
    
    
    func addItem(item: BasketItem) {
        itemList.append(item)
    }
    
    func deleteItem(item: BasketItem) {
        itemList.removeAll(where: { $0 == item })
    }
    
    func getTotalPrice() -> Int {
        
        var totalPrice = 0
        
        for item in itemList {
            totalPrice += item.totalPrice
        }
        
        return totalPrice
    }
}
