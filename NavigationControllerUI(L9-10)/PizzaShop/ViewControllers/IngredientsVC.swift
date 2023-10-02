//
//  IngredientsVC.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import UIKit

class IngredientsVC: UIViewController {


    @IBOutlet var switchButtons: [UISwitch]!
    @IBOutlet weak var pizzaLabel: UILabel!
    @IBOutlet weak var pizzaImageView: UIImageView!
    weak var navController: UINavigationController!
    
    var pizza: PizzaProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaImageView.image = pizza.image
        pizzaLabel.text = pizza.name
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? InfoVC else { return }
        destination.pizza = pizza
        
    }
    
    // Переход к оплате
    
    @IBAction func pickButtonTapped(_ sender: Any) {
        guard let paymentVC = storyboard?.instantiateViewController(withIdentifier: "payVC") as? PayViewController else { return }
        paymentVC.order = createOrder()
        self.dismiss(animated: true)
        navController.pushViewController(paymentVC, animated: true)
    }
    
    func createOrder() -> Order {
        let order: Order
        var additionals = [String]()
        for switchButton in switchButtons {
            if switchButton.isOn, let identifier = switchButton.accessibilityIdentifier {
                additionals.append(identifier)
            }
        }
        
        if additionals.isEmpty {
            order = Order(positionName: pizza.name)
        } else {
            order = Order(positionName: pizza.name, additional: additionals)
        }
        
        return order
    }
    
}
