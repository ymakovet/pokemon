//
//  PokemonDetailsPresenter.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonDetailsPresenter {
    
    weak var view: PokemonDetailsViewController!
    
    private let details: PokemonDetailsResponse
    
    init(details: PokemonDetailsResponse) {
        self.details = details
    }
    
    func fillContent() {
        
        setImage()
        
        view.nameLabel.text = details.name?.uppercased()
        view.abilityLabel.text = "Abilities:\n- " + details.abilities.map({ $0.ability.name }).joined(separator: "\n- ")
        view.typeLabel.text = "Type:\n- " + details.types.compactMap({ $0.type?.name }).joined(separator: "\n- ")
        view.heightLabel.text = "Height: " + "\(details.height ?? 0)"
        view.weightLabel.text = "Weight: " + "\(details.weight ?? 0)"
    }
    
    private func setImage(){
        
        //        `https://pokeres.bastionbot.org/images/pokemon/${pokeID}.png
        
        if let imagePath = details.sprites.frontDefault {
            view.pokemonImageView.image = CacheManager.shared.getImageBy(imagePath: imagePath)
        }
        
        let imagePath = "https://pokeres.bastionbot.org/images/pokemon/\(details.id).png"
        
        if let cachedImage = CacheManager.shared.getImageBy(imagePath: imagePath) {
            view.pokemonImageView.image = cachedImage
        } else {
            //            view.activity.startAnimating()
            DispatchQueue.global().async { [weak self] in
                guard let `self` = self else { return }
                
                guard let url = URL(string: imagePath) else { return }
                
                guard let data = try? Data(contentsOf: url) else { return }
                guard let image = UIImage(data: data) else { return }
                
                CacheManager.shared.setImage(image, by: imagePath)
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let `self` = self else { return }
                    
                    self.view.pokemonImageView.image = image
//                    view.activity.stopAnimating()
                }
            }
        }
        
    }
    
}
