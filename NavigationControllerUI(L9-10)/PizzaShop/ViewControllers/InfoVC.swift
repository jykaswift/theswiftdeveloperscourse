//
//  InfoVC.swift
//  PizzaShop
//
//  Created by Евгений Борисов on 02.10.2023.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    var pizza: PizzaProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeDownRecognizer()
        weightLabel.text = "Weight: \(pizza.weight) grams"
        configureIngredients()
    }
    
    func configureIngredients() {
        var text = ""
        for ingredient in pizza.ingredients {
            text += "\u{2022} \(ingredient.firstUppercased)\n"
        }
        ingredientsLabel.text = text
    }
    
    
    func addSwipeDownRecognizer() {
        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDownRecognizer.direction = .down
        self.view.addGestureRecognizer(swipeDownRecognizer)
    }
    
    @objc func swipeDown() {
        self.dismiss(animated: true)
    }



}
