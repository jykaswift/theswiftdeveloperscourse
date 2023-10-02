//
//  foodVC.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import UIKit

class FoodVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func sushiTapped(_ sender: Any) {
        alertCategoryInDevelop()
    }
    
    func alertCategoryInDevelop() {
        
        let alert = UIAlertController(title: "Woops", message: "sorry we deliver only pizza yet", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
        
    }
    
}
