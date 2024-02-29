//
//  LButton.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit

final class LButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configure()
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        backgroundColor = .blue
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
