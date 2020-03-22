//
//  PokemonListDataSource.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonListDataSource: NSObject {

    // MARK: - Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private unowned let presenter: PokemonListPresenter
    private unowned let model: PokemonListModel
    
    // MARK: - Lifecycle
    
    init(presenter: PokemonListPresenter, model: PokemonListModel) {
        self.presenter = presenter
        self.model = model
    }
    
    // MARK: - Internal methods
    
    func registerCell(collectionView: UICollectionView) {
        collectionView.registerCell(PokemonListCollectionCell.self)
    }
    
}

extension PokemonListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.pokemonEntities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCollectionCell.identifier, for: indexPath) as? PokemonListCollectionCell else { return UICollectionViewCell() }
        
        guard let entity = model.pokemonEntities[safe: indexPath.item] else { return cell }
        
        cell.pokemonNameLabel.attributedText = NSAttributedString(string: entity.name ?? "", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .medium),     NSAttributedString.Key.foregroundColor : UIColor.black])
        
        guard let id = entity.url?.split(separator: "/", omittingEmptySubsequences: true).last else { return cell}
        let imagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        
        if let cachedImage = CacheManager.shared.getImageBy(imagePath: imagePath) {
            cell.pokemonImageView.image = cachedImage
        } else {
            cell.activity.startAnimating()
            DispatchQueue.global().async {
                
                guard let url = URL(string: imagePath) else { return }
                
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async {
                        cell.pokemonImageView.image = UIImage(named: "no_image")
                        cell.activity.stopAnimating()
                    }
                    return
                }
                guard let image = UIImage(data: data) else { return }
                
                CacheManager.shared.setImage(image, by: imagePath)
                
                DispatchQueue.main.async { [indexPath, weak collectionView] in
                    
                    guard let collectionView = collectionView else { return }
                    guard collectionView.indexPathsForVisibleItems.contains(indexPath) else { return }
                    guard let cell = collectionView.cellForItem(at: indexPath) as? PokemonListCollectionCell else { return }
                    
                    cell.pokemonImageView.image = image
                    cell.activity.stopAnimating()
                }
            }
        }
        
        return cell
    }
}

extension PokemonListDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectPokemon(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == model.pokemonEntities.count - 4 {
            presenter.getPokemonList()
        }
    }
}
