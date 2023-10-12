//
//  SignInViewController.swift
//  DotaInformation
//
//  Created by Евгений Борисов on 12.10.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    lazy var signInLabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var loginButton = {
        let loginButton = UIButton(configuration: .filled())
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.tintColor = .red
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    lazy var emailLabel = {
        let label = UILabel()
        label.setAuthCategoryStyleWith(text: "Email")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordLabel = {
        let label = UILabel()
        label.setAuthCategoryStyleWith(text: "Password")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordShowButton = { [self] in
        let passwordButton = UIButton(type: .custom)
        passwordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordButton.sizeToFit()
        passwordButton.tintColor = .black
        passwordButton.addTarget(self, action: #selector(passwordButtonTapped(sender:)), for: .touchUpInside)
        return passwordButton
    }()
    
    
    lazy var passwordTextField = { [self] in
        let textField = UITextField()
        textField.setAuthTextFieldStyleWith(placeholder: "Enter password")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.rightView = passwordShowButton
        textField.rightViewMode = .always
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
    
    lazy var emailTextField = { [self] in
        let textField = UITextField()
        textField.setAuthTextFieldStyleWith(placeholder: "Enter email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.textContentType = .oneTimeCode
        textField.returnKeyType = .next
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpView()
    }
    
    func setup() {
        setUpLoginButton()
    }
    
    func setUpLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        guard let navigationVC = self.navigationController else { return }
        navigationVC.popViewController(animated: false)
        navigationVC.pushViewController(MainViewController(), animated: false)
    }
    
    func setUpView() {
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configureLayout() {
        view.addSubview(signInLabel)
        
        let emailStackView = UIStackView()
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        let passwordStackView = UIStackView()
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailStackView.spacing = 8
        passwordStackView.spacing = 8
        emailStackView.axis = .vertical
        passwordStackView.axis = .vertical
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextField)
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(emailStackView)
        view.addSubview(passwordStackView)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            signInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            signInLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            emailStackView.topAnchor.constraint(equalToSystemSpacingBelow: signInLabel.bottomAnchor, multiplier: 3),
            emailStackView.trailingAnchor.constraint(equalTo: signInLabel.trailingAnchor),
            emailStackView.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordStackView.topAnchor.constraint(equalToSystemSpacingBelow: emailStackView.bottomAnchor, multiplier: 2),
            passwordStackView.trailingAnchor.constraint(equalTo: signInLabel.trailingAnchor),
            passwordStackView.leadingAnchor.constraint(equalTo: signInLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordStackView.bottomAnchor, multiplier: 3),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    @objc func passwordButtonTapped(sender: UIButton) {
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    

}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            break
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}
