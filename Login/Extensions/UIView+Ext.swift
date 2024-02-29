//
//  UIView+Ext.swift
//  Login
//
//  Created by Özgün Can Beydili on 28.02.2024.
//

import UIKit

extension UIView {
    static func dismissKeyboard(view: UIView) {
        var gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(gestureRecognizer)
    }
}
