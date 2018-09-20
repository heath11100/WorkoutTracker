//
//  UICollectionViewListLayout.swift
//  WorkoutTracker
//
//  Created by Austin Heath on 9/19/18.
//  Copyright © 2018 Austin Heath. All rights reserved.
//

import UIKit

class UICollectionViewListLayout:UICollectionViewFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}
