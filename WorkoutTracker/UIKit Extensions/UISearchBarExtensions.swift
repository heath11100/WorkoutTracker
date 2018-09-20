//
//  UISearchBarExtensions.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/20/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

extension UISearchBar {
    private func getTextField() -> UITextField? { return self.value(forKey: "searchField") as? UITextField }
    
    func setTextColor(color: UIColor) {
        if let textField = getTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        if let textField = getTextField() {
            textField.tintColor = color
        }
    }
    
    func setBackgroundColor(color: UIColor) {
        if let textField = getTextField() {
            if let backgroundview = textField.subviews.first {
                // Background color
                backgroundview.backgroundColor = color
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
}
