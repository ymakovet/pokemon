//
//  PokemonListCollectionCell.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonListCollectionCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupStyles()
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    // MARK: - Private methods
    
    private func setupStyles() {
        
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func resetCell() {
        pokemonImageView.image = nil
        pokemonNameLabel.text = nil
    }
}
