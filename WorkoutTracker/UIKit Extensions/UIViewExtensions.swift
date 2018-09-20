//
//  UIViewExtensions.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

extension UIView {
    
    static func dividerView() -> UIView {
        return dividerView(withHeight: 0.50)
    }
    
    static func dividerView(withHeight: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = Style.accentColor
        view.heightAnchor.constraint(equalToConstant: withHeight).isActive = true
        return view
    }
}
