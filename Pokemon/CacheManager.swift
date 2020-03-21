//
//  CacheManager.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class CacheManager {
    
    static let shared = CacheManager()
    
    // MARK: - Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Internal methods
    
    func setImage(_ image: UIImage, by imagePath: String) {
        imageCache.setObject(image, forKey: imagePath as NSString)
    }
    
    func getImageBy(imagePath: String) -> UIImage? {
        imageCache.object(forKey: imagePath as NSString)
    }
}
