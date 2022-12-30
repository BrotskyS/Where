//
//  LoginViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 27.11.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: WABaseController, UITextViewDelegate, ChangeAuthTypeButtonDelegete {
    
    
    
    // MARK: UI Components
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()
    
    private let topImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "square.and.arrow.up.fill")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        return image
    }()
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.text = "Login"
        title.font = .systemFont(ofSize: 34, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return title
        
    }()
    
    private let emailField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "envelope", placeholder: "Email", fieldType: .email)
        
        return field
    }()
    
    private let passwordField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "lock", placeholder: "Password", fieldType: .password, isSecure: true)
        
        return field
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()
    
    private let termsTextView: UITextView = {
        let lable = UITextView()
        lable.translatesAutoresizingMaskIntoConstraints = false
        let text = "By signing up, you are agree to our Terms & Conditions and Privacy Polisy"
        var attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "terms", range: NSRange(location: 35, length: 19))
        attributedString.addAttribute(.link, value: "polisy", range: NSRange(location: 59, length: 14))
        
        
        lable.attributedText = attributedString
        lable.font = .systemFont(ofSize: 16, weight: .semibold)
        lable.isEditable = false
        lable.backgroundColor = .theme.background
        lable.textColor = .label
        lable.isScrollEnabled = false
        lable.sizeToFit()
        
        
        
        return lable
        
    }()
    
    private let loginButton: AuthButtonView = {
        let button = AuthButtonView(type: .system)
        button.configure(text: "Continue")
        button.isSpringLoaded = false
        
        return button
    }()
    
    private let deviderOr = DeviderOr()
    
    private let googleButton: AuthButtonView = {
        let button = AuthButtonView(type: .system)
        button.configure(text: "Google")
        button.backgroundColor = .systemGray5
        button.setTitleColor(.label, for: .normal)
        
        
        let image = UIImageView()
        image.image = UIImage(named: "google")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 30),
            image.heightAnchor.constraint(equalToConstant: 30),
            image.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 30),
            image.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        return button
    }()
    
    private let toRegister = ChangeAuthTypeButton()
    
    // MARK: Managers
    private let validationManager = ValidationManager()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupLayout()
        
        setupDismissKeyboardGesture()
        
    }
    
    
    // MARK: Private
    
    private func configureViews() {
        view.addSubview(stackView)
        termsTextView.delegate = self
        stackView.addArrangedSubview(topImage)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(forgotPasswordButton)
        stackView.addArrangedSubview(termsTextView)
        
        loginButton.addTarget(self, action: #selector(pressOnContinue), for: .touchUpInside)
        stackView.addArrangedSubview(loginButton)
        stackView.setCustomSpacing(0, after: loginButton)
        
        stackView.addArrangedSubview(deviderOr)
        stackView.setCustomSpacing(0, after: deviderOr)
        stackView.addArrangedSubview(googleButton)
        
        googleButton.addTarget(self, action: #selector(pressOnGoogle), for: .touchUpInside)
        
        
        toRegister.configure(lableText: "First Time", buttonText: "Register")
        toRegister.delegete = self
        
        stackView.addArrangedSubview(toRegister)
        
        
        
        
        
    }
    
    @objc func pressOnContinue() {
        // check if form valid
        
        let validationError = validationManager.validateLogin(email: emailField.getText(), password: passwordField.getText())
        
        guard let validationError = validationError else {
            // sign in by firebase
            signIn()
            return
        }
        
        switch validationError {
            case .emailEmpty, .emailIsInvalide:
                return emailField.setError(message: validationError.rawValue)
            case .passwordEmpty, .passwordIsInvalide:
                return passwordField.setError(message: validationError.rawValue)
        }
        
        
        
    }
    
    @objc func pressOnGoogle() {
        AuthManager.shared.googleAuth(self) { [weak self] error in
            if let error = error {
                self?.errorAlert(message: error)
            } else {
                self?.changeRootViewController()
            }
        }
    }
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "terms" {
            print("terms")
        } else if URL.absoluteString == "polisy" {
            print("polisy")
        } else if URL.absoluteString == "toRegister" {
            print("toRegister")
        }
        
        return false
        
    }
    
    private func signIn() {
        guard let email = emailField.getText(), let password =  passwordField.getText() else {
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [weak self] error in
            if let error = error {
                self?.errorAlert(message: error)
            } else {
                self?.changeRootViewController()
            }
        }
    }
    
    private func changeRootViewController() {
        AuthManager.shared.changeRootViewController()
    }
    
    func didTapOnChangeType() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
    }
    
}

extension LoginViewController {
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}




