//
//  LoginScreenViewModel.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import Foundation

protocol LoginScreenViewModelProtocol {
    var view: LoginScreenProtocol? { get set }
    func viewDidLoad()
}

final class LoginScreenViewModel {
    var view: LoginScreenProtocol?
}

extension LoginScreenViewModel: LoginScreenViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.buttonsTapped()
    }
}
