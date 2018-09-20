//
//  NavigationController.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/20/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class NavigationController:UINavigationController {
    private let exerciseListViewController = ExerciseListViewController()
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavigationBar()
        styleToolbar()
        
        self.viewControllers = [self.exerciseListViewController]
        
        self.view.backgroundColor = UIColor.white
    }
    
    func styleNavigationBar() {
        self.navigationBar.tintColor = Style.backgroundColor
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : Style.backgroundColor]
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Style.backgroundColor]
        self.navigationBar.barTintColor = Style.accentColor
        self.navigationBar.isTranslucent = false
        
        self.navigationBar.prefersLargeTitles = true
        self.setNavigationBarHidden(false, animated: false)
    }
    
    func styleToolbar() {
        self.toolbar.barStyle = .default
        self.toolbar.isTranslucent = true
    }
}
