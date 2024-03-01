//
//  CreateAccountScreen.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit
import FirebaseAuth

protocol CreateAccountScreenProtocol: AnyObject {
    func configureVC()
    func buttonsTapped()
}

final class CreateAccountScreen: UIViewController {

    private let viewModel = CreateAccountScreenViewModel()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(resource: .logo1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()
    
    private var emailLabel = LLabel(text: "Email")
    private var emailTextField = LTextField(placeholder: "Enter Email: ")
    private var passwordLabel = LLabel(text: "Password")
    private var passwordTextField = LTextField(placeholder: "Enter Password: ")
    private var passwordAgainLabel = LLabel(text: "Password Again")
    private var passwordAgainTextField = LTextField(placeholder: "Enter Password Again: ")
    
    private var haveAccountButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("You have already account?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private var createAccountButton = LButton(title: "Create Account")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        clearAll()
    }
}

extension CreateAccountScreen: CreateAccountScreenProtocol {
    func configureVC() {
        view.backgroundColor = .systemBackground
        UIView.dismissKeyboard(view: view)
        
        
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField.isSecureTextEntry = true
        
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainLabel)
        view.addSubview(passwordAgainTextField)
        view.addSubview(haveAccountButton)
        view.addSubview(createAccountButton)
    }
    
    private func layoutUI() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 2 * padding),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailLabel.heightAnchor.constraint(equalToConstant: padding),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: padding / 2),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 2 * padding),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            passwordLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: padding),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: padding / 2),
            passwordTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 2 * padding),
            
            passwordAgainLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            passwordAgainLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordAgainLabel.heightAnchor.constraint(equalToConstant: padding),
            
            passwordAgainTextField.topAnchor.constraint(equalTo: passwordAgainLabel.bottomAnchor, constant: padding / 2),
            passwordAgainTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordAgainTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            passwordAgainTextField.heightAnchor.constraint(equalToConstant: 2 * padding),
            
            haveAccountButton.topAnchor.constraint(equalTo: passwordAgainTextField.bottomAnchor, constant: padding),
            haveAccountButton.leadingAnchor.constraint(equalTo: passwordAgainTextField.leadingAnchor),
            haveAccountButton.heightAnchor.constraint(equalToConstant: padding),
            
            createAccountButton.topAnchor.constraint(equalTo: haveAccountButton.bottomAnchor, constant: padding),
            createAccountButton.leadingAnchor.constraint(equalTo: passwordAgainTextField.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: passwordAgainTextField.trailingAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 2.5 * padding)
        ])
    }
    
    func buttonsTapped() {
        haveAccountButton.addTarget(self, action: #selector(haveAccountButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func haveAccountButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func createAccountButtonTapped() {
        if emailTextField.text == "" || passwordTextField.text == "" || passwordAgainTextField.text == "" {
            presentAlertOnMainThread(title: "Fill the Blanks!", message: "Please make sure that all the blanks are filled.", buttonTitle: "Ok")
        }
        else if passwordTextField.text != passwordAgainTextField.text {
            presentAlertOnMainThread(title: "Attention!", message: "Passwords must be same!", buttonTitle: "Ok")
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                if error != nil {
                    self.presentAlertOnMainThread(title: "Error!", message: error?.localizedDescription ?? "Unexpected error! Make sure everything is correct.", buttonTitle: "Ok")
                }
                else {
                    self.presentAlertOnMainThread(title: "Done!", message: "Your account was created successfully.", buttonTitle: "Ok")
                    self.clearAll()
                }
            }
        }
    }
    
    private func clearAll() {
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordAgainTextField.text = ""
    }
}
