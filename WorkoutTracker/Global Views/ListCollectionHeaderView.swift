//
//  ListCollectionHeaderView.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/20/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class ListCollectionHeaderView:UICollectionViewCell {
    let titleLabel = UILabel()
    
    private let divider = UIView.dividerView(withHeight: 0.75)
    
    private var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.divider.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "Sample Header"
        self.titleLabel.textColor = Style.accentColor
        self.titleLabel.font = UIFont.systemFont(ofSize: self.titleLabel.font.pointSize, weight: .semibold)
        
        self.contentView.addSubview(self.divider)
        self.contentView.addSubview(self.titleLabel)
        
        if shouldSetupConstraints {
            NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4.0),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                self.divider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                self.divider.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
                ])
            self.shouldSetupConstraints = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
