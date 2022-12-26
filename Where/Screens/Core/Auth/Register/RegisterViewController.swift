//
//  LoginViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: WABaseController, UITextViewDelegate, ChangeAuthTypeButtonDelegete {
    
    
    
    // MARK: Views
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
        
        return image
    }()
    
    private let titleView: UILabel = {
        let title = UILabel()
        title.text = "Sign Up"
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
    
    private let passwordRepeateField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "lock", placeholder: "Repeat Password", fieldType: .password, isSecure: true)
        
        return field
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
        
        lable.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        
        return lable
        
    }()
    
    private let loginButton: AuthButtonView = {
        let button = AuthButtonView(type: .system)
        button.configure(text: "Continue")
        
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
    
    private let toLogin = ChangeAuthTypeButton()
    
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
        stackView.addArrangedSubview(passwordRepeateField)
        stackView.addArrangedSubview(termsTextView)
        
        loginButton.addTarget(self, action: #selector(pressOnContinue), for: .touchUpInside)
        stackView.addArrangedSubview(loginButton)
        stackView.setCustomSpacing(0, after: loginButton)
        
        stackView.addArrangedSubview(deviderOr)
        stackView.setCustomSpacing(0, after: deviderOr)
        
        
        stackView.addArrangedSubview(googleButton)
        
        toLogin.configure(lableText: "Joined us before?", buttonText: "Login")
        toLogin.delegete = self
        stackView.addArrangedSubview(toLogin)
        
        
        
    }
    
    
    
    @objc private func pressOnContinue() {
     
        // Check fields with regex
        let validationError =  validationManager.validateRegister(
            email: emailField.getText(),
            password: passwordField.getText(),
            passwordRepeate: passwordRepeateField.getText()
        )
        
        guard let validationError = validationError else {
            return signUp()
            
        }
        
        switch validationError {
            case .emailEmpty, .emailIsInvalide :
                emailField.setError(message: validationError.rawValue)
            case .passwordEmpty, .passwordIsInvalide:
                passwordField.setError(message: validationError.rawValue)
            case .passwordsNotSame:
                passwordRepeateField.setError(message: validationError.rawValue)
        }
        
    }
    
    private func signUp() {
        guard let email = emailField.getText(), let password =  passwordField.getText() else {
            return
        }
        AuthManager.shared.signUp(email: email, password: password) { [weak self] error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    print("Ok")
                }))
                self?.present(alert, animated: true)
            } else {
                let vc = TabBarController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        
        if URL.absoluteString == "terms" {
            print("terms")
            
        } else if URL.absoluteString == "polisy" {
            print("polisy")
        }
        
        return false
        
    }
    
    func didTapOnChangeType() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension RegisterViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            
        ])
    }
    
    
}

