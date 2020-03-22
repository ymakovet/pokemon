//
//  Models.swift
//  Pokemon
//
//  Created by Temp on 3/22/20.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import UIKit

enum Tab: Int, CaseIterable {
    case firsType
    case secondType
    case thirdType
    case all
    
    var model: PokemonListModel {
        switch self {
        case .firsType:
            return PokemonListByTypeModel(url: "https://pokeapi.co/api/v2/type/1/")
        case .secondType:
            return PokemonListByTypeModel(url: "https://pokeapi.co/api/v2/type/3/")
        case .thirdType:
            return PokemonListByTypeModel(url: "https://pokeapi.co/api/v2/type/2/")
        case .all:
            return PokemonListAllModel()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .firsType:
            return UIImage(named: "first_type")
        case .secondType:
             return UIImage(named: "second_type")
        case .thirdType:
            return UIImage(named: "third_type")
        case .all:
            return UIImage(named: "all_pokemon")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .firsType:
            return UIImage(named: "first_type_fill")
        case .secondType:
             return UIImage(named: "second_type_fill")
        case .thirdType:
            return UIImage(named: "third_type_fill")
        case .all:
            return UIImage(named: "all_pokemon_fill")
        }
    }
}
