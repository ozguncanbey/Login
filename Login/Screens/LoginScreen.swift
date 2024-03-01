//
//  LoginScreen.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit
import FirebaseAuth

protocol LoginScreenProtocol: AnyObject {
    func configureVC()
    func buttonsTapped()
}

final class LoginScreen: UIViewController {

    private let viewModel = LoginScreenViewModel()
    
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
    
    private var forgotPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    private var loginButton = LButton(title: "Log In")
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

extension LoginScreen: LoginScreenProtocol {
    func configureVC() {
        view.backgroundColor = .systemBackground
        UIView.dismissKeyboard(view: view)
        
        passwordTextField.isSecureTextEntry = true
        
        addSubviews()
        layoutUI()
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
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
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: padding),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: padding),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 2.5 * padding),
            
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: padding),
            createAccountButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 2.5 * padding)
        ])
    }
    
    func buttonsTapped() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        presentAlertOnMainThread(title: "Link Sent!", message: "Click on the link in your email to reset your password.", buttonTitle: "Ok")
    }
    
    @objc private func loginButtonTapped() {
        if emailTextField.text == "" || passwordTextField.text == "" {
            presentAlertOnMainThread(title: "Fill the Blanks!", message: "Please make sure that all the blanks are filled.", buttonTitle: "Ok")
        }
        else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                if error != nil {
                    self.presentAlertOnMainThread(title: "Error!", message: error?.localizedDescription ?? "Unexpected error! Make sure everything is correct.", buttonTitle: "Ok")
                }
                else {
                    self.presentAlertOnMainThread(title: "Done!", message: "You've managed to log in.", buttonTitle: "Ok")
                    self.clearAll()
                }
            }
        }
    }
    
    @objc private func createAccountButtonTapped() {
        navigationController?.pushViewController(CreateAccountScreen(), animated: true)
    }
    
    private func clearAll() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
