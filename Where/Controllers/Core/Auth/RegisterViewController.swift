//
//  LoginViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import UIKit

class RegisterViewController: UIViewController, UITextViewDelegate {
    
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
        
        return title
        
    }()
    
    private let emailField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "envelope", placeholder: "Email")
        
        return field
    }()
    
    private let passwordField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "lock", placeholder: "Password", isSecure: true)
        
        return field
    }()
    
    private let passwordRepeateField: AuthTextFieldView = {
        let field = AuthTextFieldView()
        field.configure(imageIcon: "lock", placeholder: "Repeat Password", isSecure: true)
        
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
        lable.isSelectable = false
        lable.backgroundColor = .theme.background
        lable.textColor = .label
        
        lable.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        
        return lable
        
    }()
    
    private let loginButton: AuthButtonView = {
        let button = AuthButtonView()
        button.configure(text: "Continue")
        
        return button
    }()
    
    private let deviderOr: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "OR"
        lable.textColor = .label
        
    
        let deviderLeft = DeviderView()
        
        let deviderRight = DeviderView()

        
        view.addSubview(deviderLeft)
        view.addSubview(lable)
        view.addSubview(deviderRight)
        
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            lable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            deviderLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deviderLeft.trailingAnchor.constraint(equalTo: lable.leadingAnchor, constant: -10),
            deviderLeft.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            deviderRight.leadingAnchor.constraint(equalTo: lable.trailingAnchor, constant: 10),
            deviderRight.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            deviderRight.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
        ])
        return view
    }()
    
    private let googleButton: AuthButtonView = {
        let button = AuthButtonView()
        button.configure(text: "Google")
        
        return button
    }()
    
    private let toLogin: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let text = "Joined us before? Login"
        var attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "toLogin", range: NSRange(location: 18, length: 5))
        
        
        
        textView.attributedText = attributedString
        textView.font = .systemFont(ofSize: 16, weight: .semibold)
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .theme.background
        textView.textColor = .label
        textView.textAlignment = .center
        
        textView.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        
        return textView
        
    }()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        navigationController?.isNavigationBarHidden = true
        
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
        stackView.addArrangedSubview(loginButton)
        stackView.setCustomSpacing(0, after: loginButton)

        stackView.addArrangedSubview(deviderOr)
        stackView.setCustomSpacing(0, after: deviderOr)
    
        
        stackView.addArrangedSubview(googleButton)
        stackView.addArrangedSubview(toLogin)
        
        
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "terms" {
            print("terms")
        } else if URL.absoluteString == "polisy" {
            print("polisy")
        }
        
        return false
        
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
    
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            view.endEditing(true) // resign first responder
        }
    }
    
    
}

