//
//  PokemonListDataSource.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

final class PokemonListDataSource: NSObject {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private unowned let presenter: PokemonListPresenter
    private unowned let model: PokemonListModel
    
    init(presenter: PokemonListPresenter, model: PokemonListModel) {
        self.presenter = presenter
        self.model = model
    }
    
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
        
        cell.pokemonNameLabel.text = entity.name
        
        guard let id = entity.url?.split(separator: "/", omittingEmptySubsequences: true).last else { return cell}
        let imagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        
        if let cachedImage = CacheManager.shared.getImageBy(imagePath: imagePath) {
            cell.pokemonImageView.image = cachedImage
        } else {
            cell.activity.startAnimating()
            DispatchQueue.global().async { [weak self] in
                guard let `self` = self else { return }
                
                guard let url = URL(string: imagePath) else { return }
                
                guard let data = try? Data(contentsOf: url) else { return }
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
        if indexPath.row == model.pokemonEntities.count - 8 {
            presenter.getPokemonList()
        }
    }
}

//extension PokemonListDataSource: UICollectionViewDataSourcePrefetching {
//    
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        
//        indexPaths.forEach { (indexPath: IndexPath) in
//            model.getPokemonDetails(index: indexPath.item) { [weak collectionView, indexPath] in
//                DispatchQueue.main.async {
//                    collectionView?.reloadItems(at: [indexPath])
//                }
//            }
//        }
//        
//    }
//    
//}
