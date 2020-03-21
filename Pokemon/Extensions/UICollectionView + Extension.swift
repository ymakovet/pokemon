//
//  UICollectionView + Extension.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ class: T.Type) {
        let name = String(describing: `class`.self)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    
}
