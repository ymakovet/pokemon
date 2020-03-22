//
//  PokemonDetailsPresenter.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonDetailsPresenter {
    
    // MARK: - Properties
    
    weak var view: PokemonDetailsViewController!
    
    private let details: PokemonDetailsResponse
    
    // MARK: - Lifecycle
    
    init(details: PokemonDetailsResponse) {
        self.details = details
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    // MARK: - Internal methods
    
    func fillContent() {
        
        setImage()
        
        view.nameLabel.text = details.name?.uppercased()
        view.abilityLabel.text = "- " + details.abilities.map({ $0.ability.name }).joined(separator: "\n- ")
        view.typeLabel.text = "- " + details.types.compactMap({ $0.type?.name }).joined(separator: "\n- ")
        view.heightLabel.text = "\(details.height ?? 0)"
        view.weightLabel.text = "\(details.weight ?? 0)"
    }
    
    private func setImage() {
        
        if let imagePath = details.sprites.frontDefault {
            view.pokemonImageView.image = CacheManager.shared.getImageBy(imagePath: imagePath)
        }
        
        let imagePath = "https://pokeres.bastionbot.org/images/pokemon/\(details.id).png"
        
        if let cachedImage = CacheManager.shared.getImageBy(imagePath: imagePath) {
            view.pokemonImageView.image = cachedImage
        } else {
            DispatchQueue.global().async { [weak self] in
                guard let `self` = self else { return }
                
                guard let url = URL(string: imagePath) else { return }
                
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async { [weak self] in
                        
                        guard let `self` = self else { return }
                        self.view.pokemonImageView.image = UIImage(named: "no_image")
                    }
                    return
                }
                guard let image = UIImage(data: data) else { return }
                
                CacheManager.shared.setImage(image, by: imagePath)
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let `self` = self else { return }
                    self.view.pokemonImageView.image = image
                }
            }
        }
    }
}
