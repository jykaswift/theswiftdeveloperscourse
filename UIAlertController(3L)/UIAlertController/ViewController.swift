//
//  ViewController.swift
//  UIAlertController
//
//  Created by Евгений Борисов on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var currentGameLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fioLabel.isHidden = true
        currentGameLabel.isHidden = true
        resultLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showFIOAlert()
    }
    
    
    func showFIOAlert() {
        let alertController = UIAlertController(
            title: "Hi!",
            message: "Enter Your name: ",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "Enter name"
        }
        let action = UIAlertAction(title: "Done", style: .default) {_ in
            let name = alertController.textFields?.first?.text ?? "Noname"
            self.fioLabel.text = "Hi, \(name)"
            self.fioLabel.isHidden = false
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
        
    }
    
    func showInfoAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "ok", style: .default)
        
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

    @IBAction func adittionButtonTapped(_ sender: UIButton) {
        self.currentGameLabel.text = "Current Game: Addition"
        self.currentGameLabel.isHidden = false
        alertAddition()
        
    }
    @IBAction func guessButtonTapped(_ sender: UIButton) {
        self.currentGameLabel.text = "Current Game: Guess Number"
        self.currentGameLabel.isHidden = false
        alertGuessNumber()
        
    }
    
    func alertGuessNumber() {
        let alertController = UIAlertController(
            title: "Game: AdittionGame",
            message: "Enter number in range 1-9",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "Enter number"
        }
        let action = UIAlertAction(title: "Done", style: .default) {_ in
            let number = Int(alertController.textFields?.first?.text ?? "None")
            let randomNumber = Int.random(in: 1...9)
            if let number, number == randomNumber {
                self.resultLabel.text = "Congratulations, you guessed the number"
            } else {
                self.resultLabel.text = " Unfortunately you guessed wrong :(\nIt was number \(randomNumber)\nTry again"
            }
            self.resultLabel.isHidden = false
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
        
    }
    
    func alertAddition() {
        let alertController = UIAlertController(
            title: "Game: AdittionGame",
            message: "Enter 2 numbers",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "First number"
        }
        alertController.addTextField() { textField in
            textField.placeholder = "Second number"
        }
        let action = UIAlertAction(title: "Calculate", style: .default) {_ in
            let firstNumber = Int(alertController.textFields?.first?.text ?? "None")
            let secondNumber = Int(alertController.textFields?[1].text ?? "None")
            if let firstNumber, let secondNumber {
                self.resultLabel.text = "Result = \(firstNumber + secondNumber)"
                self.resultLabel.isHidden = false
            } else {
                self.showInfoAlert(title: "Input Error", message: "You should enter numbers in both fields")
                self.resultLabel.isHidden = true
            }
            
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
}

