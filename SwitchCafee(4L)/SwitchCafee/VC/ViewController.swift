//
//  ViewController.swift
//  SwitchCafee
//
//  Created by Евгений Борисов on 17.09.2023.
//

import UIKit

class ViewController: UIViewController {
        
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    let loginTextField = UITextView()
    let signInLabel = UILabel()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenWidth = view.frame.width
        // Logotype
        logoImage.frame = CGRect(x: (view.frame.width / 2) - 75, y: 100, width: 150, height: 150)
        self.view.addSubview(logoImage)
        
        // Sign In Label
        signInLabel.text = "Sign In"
        signInLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 26)
        signInLabel.frame = CGRect(x: 20, y: logoImage.frame.maxY, width: 200, height: 40)
        self.view.addSubview(signInLabel)
        
        // Email label
        
        emailLabel.text = "Email"
        emailLabel.setFontTFLabel()
        emailLabel.frame = CGRect(x: 20, y: signInLabel.frame.maxY + 10, width: 200, height: 30)
        
        self.view.addSubview(emailLabel)
        
        // Email TF
        
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .none
        emailTextField.frame = CGRect(x: 20, y: Int(emailLabel.frame.maxY), width: Int(screenWidth) - 40, height: 40)
        emailTextField.setUnderLine()
        self.view.addSubview(emailTextField)
        
        // Password Label
        
        passwordLabel.text = "Password"
        passwordLabel.setFontTFLabel()
        passwordLabel.frame = CGRect(x: 20, y: emailTextField.frame.maxY + 20, width: 200, height: 30)
        self.view.addSubview(passwordLabel)
        
        // Password TF
        
        passwordTextField.placeholder = "Enter password"
        passwordTextField.borderStyle = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 20, y: Int(passwordLabel.frame.maxY), width: Int(screenWidth) - 40, height: 40)
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "view"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.imageView?.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(button)
        button.addTarget(self, action: #selector(eyeButtonTapped(target:)), for: .touchUpInside)
        passwordTextField.rightView = iconContainerView
        passwordTextField.rightViewMode = .always
        passwordTextField.setUnderLine()

        self.view.addSubview(passwordTextField)
        
        
        // Button Sign In
        
        signButton.frame = CGRect(x: 20, y: Int(passwordTextField.frame.maxY) + 50, width: Int(screenWidth) - 40, height: 40)
        signButton.backgroundColor = .red
        signButton.setTitle("Sign in", for: .normal)
        signButton.titleLabel?.textColor = .red
        signButton.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
        self.view.addSubview(signButton)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func signButtonTapped() {
        let secondVC = SecondVC()
        secondVC.delegate = self
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true)
    }
    

    @objc func eyeButtonTapped(target: UIButton) {
        
        if self.passwordTextField.isSecureTextEntry {
            target.setImage(UIImage(named: "hide"), for: .normal)
        } else {
            target.setImage(UIImage(named: "view"), for: .normal)
        }
        
        self.passwordTextField.isSecureTextEntry.toggle()
    }

}

extension UILabel {
    func setFontTFLabel() {
        self.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.textColor = .red
    }
}

extension UITextField {
    
    

    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height - width,
            width: self.frame.size.width - 10,
            height: self.frame.size.height
        )
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
