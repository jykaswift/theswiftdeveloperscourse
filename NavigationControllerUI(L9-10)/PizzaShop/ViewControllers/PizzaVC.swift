//
//  PizzaVC.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import UIKit

class PizzaVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? IngredientsVC else { return }
        
        let pizza: PizzaProtocol
        
        switch segue.identifier {
        case "fourCheeses":
            pizza = FourChesses()
        default:
            pizza = Pepperoni()
        }
        
        destination.pizza = pizza
        destination.navController = navigationController
        
    }
    

}
