//
//  ViewController.swift
//  BirthdayReminder
//
//  Created by Евгений Борисов on 20.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        welcomeLabel.layer.borderWidth = 1
        welcomeLabel.layer.borderColor = UIColor.black.cgColor
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()

        signInButton.layer.cornerRadius = 10
        signInButton.addShadowWith(color: .red)
        addShowButtonToTextField()
    }
    
    func addShowButtonToTextField() {
        
        let buttonView = UIView()
        let button = UIButton()
        button.setImage(UIImage(named: "hide"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        buttonView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        buttonView.addSubview(button)
        button.addTarget(self, action: #selector(showButtonTapped(sender:)), for: .touchUpInside)
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView = buttonView
        
    }
    
    @objc func showButtonTapped(sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "view"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "hide"), for: .normal)
        }
        
    }
}

extension UIView {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height + 10, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLine)
    }
}


extension UIButton {
    
    func addShadowWith(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
    
}

