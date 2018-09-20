//
//  UIToolbarExtensions.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

extension UIToolbar {
    
    static func getItems(withButtonText text:String, target:AnyObject?, action:Selector?) -> [UIBarButtonItem] {
        let button = UIBarButtonItem(title: text, style: .done, target: target, action: action)
        button.tintColor = Style.accentColor
        return [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                button,
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
    }
    
    static func getItems(leftButtonText leftText:String, leftTarget:AnyObject?, leftAction:Selector?,
                         rightButtonText rightText:String, rightTarget:AnyObject?, rightAction:Selector?) -> [UIBarButtonItem] {
        return [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: leftText, style: .done, target: leftTarget, action: leftAction),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: rightText, style: .done, target: rightTarget, action: rightAction),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
    }
}
