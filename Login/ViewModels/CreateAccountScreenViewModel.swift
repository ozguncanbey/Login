//
//  CreateAccountScreenViewModel.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import Foundation

protocol CreateAccountScreenViewModelProtocol {
    var view: CreateAccountScreenProtocol? { get set }
    func viewDidLoad()
}

final class CreateAccountScreenViewModel {
    var view: CreateAccountScreenProtocol?
}

extension CreateAccountScreenViewModel: CreateAccountScreenViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.buttonsTapped()
    }
}
