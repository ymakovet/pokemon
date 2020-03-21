//
//  PokemonListModel.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation

protocol PokemonListModel: AnyObject {
    var pokemonEntities: [PokemonEntity] { get }
    
    func getPokemonList(completion: @escaping () -> Void)
    func getPokemonDetails(index: Int, completion: @escaping (PokemonDetailsResponse) -> Void)
}
