//
//  ViewController.swift
//  DotaInformation
//
//  Created by Евгений Борисов on 11.10.2023.
//

import UIKit

class SignUpVC: UIViewController {
    
    lazy var registationLabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var haveAccountButton = {
        let haveAccountButton = UIButton(configuration: .plain())
        haveAccountButton.setTitle("I have an account", for: .normal)
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        return haveAccountButton
    }()
    
    lazy var loginButton = {
        let loginButton = UIButton(configuration: .filled())
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.tintColor = .red
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        let attributedLabel = NSMutableAttributedString()
        let dotaPart = NSMutableAttributedString(
            string: "DOTA", 
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 42, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.red
            ]
        )
        
        let profilePart = NSMutableAttributedString(
            string: " PROFILE",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 42, weight: .bold)
            ]
        )
        
        attributedLabel.append(dotaPart)
        attributedLabel.append(profilePart)
        label.attributedText = attributedLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginLabel = {
        let label = UILabel()
        label.setAuthCategoryStyleWith(text: "Login")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    lazy var loginTextField = { [self] in
        let textField = UITextField()
        textField.setAuthTextFieldStyleWith(placeholder: "Enter login")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .next
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
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    lazy var loginWarningLabel = {
        let loginWarningLabel = UILabel()
        loginWarningLabel.text = "Username must consist of more than 5 characters"
        loginWarningLabel.setWarningMessageStyle()
        return loginWarningLabel
    }()
    
    lazy var passwordWarningLabel = {
        let passwordWarningLabel = UILabel()
        passwordWarningLabel.setWarningMessageStyle()
        passwordWarningLabel.text = "Password must consist of more than 6 characters"
        return passwordWarningLabel
    }()
    
    lazy var emailWarningLabel = {
        let emailWarningLabel = UILabel()
        emailWarningLabel.text = "Incorrect email"
        emailWarningLabel.setWarningMessageStyle()
        return emailWarningLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setUpView()
    }
    
    
    func setup() {
        setupKeyboardHiding()
        setUpLoginButton()
        setUpHaveAccountButton()
    }
    
    func setUpHaveAccountButton() {
        haveAccountButton.addTarget(self, action: #selector(haveAccountButtonPressed), for: .touchUpInside)
    }
    
    @objc func haveAccountButtonPressed() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func setUpLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        if !isAnyWarnings() {
            navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    func setUpView() {
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configureLayout() {
        let loginStackView = embedFormIntoStackView(views: loginLabel, loginTextField, loginWarningLabel)
        let emailStackView = embedFormIntoStackView(views: emailLabel, emailTextField, emailWarningLabel)
        let passwordStackView = embedFormIntoStackView(views: passwordLabel, passwordTextField, passwordWarningLabel)
        let allFormStackView = UIStackView()
        allFormStackView.translatesAutoresizingMaskIntoConstraints = false
        allFormStackView.addArrangedSubview(loginStackView)
        allFormStackView.addArrangedSubview(emailStackView)
        allFormStackView.addArrangedSubview(passwordStackView)
        allFormStackView.axis = .vertical
        allFormStackView.spacing = 15
        
        view.addSubview(titleLabel)
        view.addSubview(registationLabel)
        view.addSubview(allFormStackView)
        view.addSubview(loginButton)
        view.addSubview(haveAccountButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            registationLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            registationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            registationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            allFormStackView.topAnchor.constraint(equalToSystemSpacingBelow: registationLabel.bottomAnchor, multiplier: 2),
            allFormStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            allFormStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: allFormStackView.bottomAnchor, multiplier: 2),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            haveAccountButton.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 1),
            haveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    func embedFormIntoStackView(views: UIView...) -> UIStackView {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for view in views {
            stackView.addArrangedSubview(view)
        }
        return stackView
    }
    
    func isAnyWarnings() -> Bool {
        
        var warningState = false
        
        if !Validator.isValidEmail(email: emailTextField.text) {
            emailWarningLabel.isHidden = false
            warningState = true
        } else {
            emailWarningLabel.isHidden = true
        }
        
        if !Validator.isValidPassword(password: passwordTextField.text) {
            passwordWarningLabel.isHidden = false
            warningState = true
        } else {
            passwordWarningLabel.isHidden = true
        }
        
        if !Validator.isValidUsername(username: loginTextField.text) {
            loginWarningLabel.isHidden = false
            warningState = true
        } else {
            loginWarningLabel.isHidden = true
        }
        
        return warningState
    }


}

extension UILabel {
    
    func setAuthCategoryStyleWith(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 18)
        self.textColor = .black
    }
    
    func setWarningMessageStyle() {
        self.font = UIFont.systemFont(ofSize: 12)
        self.textColor = .red
        self.isHidden = true
        self.numberOfLines = 0
    }
    
}

extension UIView {
    func addBottomBorder() {
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = .gray
        self.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3)
        ])
    }
}

extension UITextField {
    
    func setAuthTextFieldStyleWith(placeholder: String) {
        self.placeholder = placeholder
        self.textColor = .black
        self.adjustsFontSizeToFitWidth = true
        self.addBottomBorder()
    }
    
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginButton.sendActions(for: .touchUpInside)
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

extension SignUpVC {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension UIViewController {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
