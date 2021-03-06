//
//  PokemonListPresenter.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation

final class PokemonListPresenter {
    
    // MARK: - Properties
    
    weak var view: PokemonListViewController!
    
    private let model: PokemonListModel
    
    private(set) lazy var dataSource = PokemonListDataSource(presenter: self, model: model)
    
    // MARK: - Lifecycle
    
    init(model: PokemonListModel) {
        self.model = model
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    // MARK: - Internal methods
    
    func handleViewDidLoadEvent() {
        
        dataSource.registerCell(collectionView: view.collectionView)
        
        view.collectionView.delegate = dataSource
        view.collectionView.dataSource = dataSource
        
        getPokemonList()
    }
    
    func getPokemonList() {
        model.getPokemonList { [weak self] in
            guard let `self` = self else { return }
            
            self.view.navigationItem.title = self.model.title.uppercased()
            self.view.collectionView.reloadData()
        }
    }
    
    func didSelectPokemon(index: Int) {
        
        self.view.loadingView.isHidden = false
        self.view.activity.startAnimating()
        
        model.getPokemonDetails(index: index) { [weak self] (details) in
            
            guard let `self` = self else { return }
            
            let presenter = PokemonDetailsPresenter(details: details)
            let vc = PokemonDetailsViewController(presenter: presenter)
            
            vc.hidesBottomBarWhenPushed = true
            self.view.navigationController?.pushViewController(vc, animated: true)
            
            self.view.loadingView.isHidden = true
            self.view.activity.stopAnimating()
        }
    }
}
