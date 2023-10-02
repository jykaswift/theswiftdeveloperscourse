//
//  Pizza.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import Foundation
import UIKit

protocol PizzaProtocol {
    
    var name: String { get }
    var image: UIImage { get }
    var ingredients: [String] { get }
    var weight: Int { get }
    
}

struct Pepperoni: PizzaProtocol {
    var image: UIImage = UIImage(named: "peperoni") ?? UIImage(systemName: "no image")!

    var name = "Pepperoni"

    var ingredients = [
        "пепперони",
        "масло острое",
        "соус томатный",
        "тесто для пиццы",
        "сыр моцарелла"
    ]
    
    var weight = 500
    
}

struct FourChesses: PizzaProtocol {
    var image: UIImage = UIImage(named: "4chees") ?? UIImage(systemName: "no image")!

    var name = "Four Chesses"

    var ingredients = [
        "моцарелла",
        "сыр горгонзола",
        "пармезан",
        "тесто для пиццы",
        "моцарелла в рассоле",
        "соус сырный"
    ]
    
    var weight = 500
    
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
