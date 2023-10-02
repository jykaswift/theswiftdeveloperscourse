//
//  Order.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import Foundation

class Order {
    
    var positionName: String
    var additional: [String]?
    
    init(positionName: String) {
        self.positionName = positionName
    }
    
    convenience init(positionName: String, additional: [String]) {
        self.init(positionName: positionName)
        self.additional = additional
    }
    
}
