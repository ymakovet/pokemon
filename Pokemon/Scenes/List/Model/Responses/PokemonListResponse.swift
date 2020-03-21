//
//  PokemonListResponse.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonEntity]
}

struct PokemonEntity: Decodable {
    let name: String?
    let url: String?
}
