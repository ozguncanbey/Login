//
//  LLabel.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit

final class LLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String) {
        super.init(frame: .zero)
        configure()
        self.text = text
    }
    
    private func configure() {
        textColor = .blue
        font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
