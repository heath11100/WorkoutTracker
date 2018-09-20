//
//  ListCollectionViewCell.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class ListCollectionViewCell:UICollectionViewCell {
    private let imageView:UIImageView
    private let divider:UIView
    
    let titleLabel = UILabel()
    
    private var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        self.imageView = UIImageView(image: UIImage(named: "right_arrow"))
        self.divider = UIView.dividerView()
        
        super.init(frame: frame)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.divider.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "Sample text"
        
        self.contentView.addSubview(self.divider)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)
        
        if shouldSetupConstraints {
            NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 4.0),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -4.0),
                self.imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                self.imageView.widthAnchor.constraint(equalToConstant: 15.0),
                self.imageView.heightAnchor.constraint(equalToConstant: 15.0),
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
