//
//  LTextField.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit

final class LTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        configure()
        self.placeholder = placeholder
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
        
        textColor = .label
        tintColor = .label
        
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        backgroundColor = .tertiarySystemBackground
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 10
        
        autocorrectionType = .no
        autocapitalizationType = .none
        keyboardType = .emailAddress
        returnKeyType = .next
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
