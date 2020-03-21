//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation

struct PokemonDetailsResponse: Decodable {
    let sprites: Sprites
    let id: Int
    let height: Int?
    let weight: Int?
    let types: [Types]
    let name: String?
    let abilities: [Abilities]
    
    struct Sprites: Decodable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
        
    }
    
    struct Types: Decodable {
        let type: PokemonType?
        
        struct PokemonType: Decodable {
             let name: String?
        }
    }
    
    struct Abilities: Decodable {
        let ability: Ability
        
        struct Ability: Decodable {
            let name: String
        }
    }
}
