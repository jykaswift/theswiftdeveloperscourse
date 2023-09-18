//
//  SecondViewController.swift
//  UIAlertController
//
//  Created by Евгений Борисов on 15.09.2023.
//

import UIKit

class SecondViewController: UIViewController {
    let gameModel = GameModel()
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Hi!",
            message: "Enter leohl: ",
            preferredStyle: .alert
        )
        alertController.addTextField() { textField in
            textField.placeholder = "Enter leohl"
        }
        let action = UIAlertAction(title: "Go", style: .default) {_ in
            let text = alertController.textFields?.first?.text ?? ""
            let hello = self.gameModel.getHelloFrom(input: text)
            self.resultLabel.isHidden = false
            self.resultLabel.text = hello
        }
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
        
        
    }
}
