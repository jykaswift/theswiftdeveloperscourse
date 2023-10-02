//
//  PayViewController.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var additionalsLabel: UILabel!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    
    var order: Order!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Payment"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        pizzaNameLabel.text = order.positionName
        additionalsLabel.text = order.additional!.reduce("", { $0 + "\u{2022}\($1)\n" })
        
    }
    
    
    @IBAction func payButtonTapped(_ sender: Any) {
        showPaymentAlert()
    }
    
    func showPaymentAlert() {
        let alert = UIAlertController(title: "Congratulations", message: "The order was successfully paid", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [self] _ in
            guard let vc = self.navigationController?.viewControllers.filter({ $0 is FoodVC }).first else { return }
            self.navigationController?.popToViewController(vc, animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    


}
