//
//  PokemonListModel.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation
import Alamofire

protocol PokemonListModel: AnyObject {
    var pokemonEntities: [PokemonEntity] { get }
    var title: String { get }
    
    func getPokemonList(completion: @escaping () -> Void)
    func getPokemonDetails(index: Int, completion: @escaping (PokemonDetailsResponse) -> Void)
}

extension PokemonListModel {
    private func getPokemonDetailsRequest(index: Int, completion: @escaping (Result<PokemonDetailsResponse, Error>) -> Void) {
        
        guard let name = pokemonEntities[safe: index]?.name else { return }
        AF.request("https://pokeapi.co/api/v2/pokemon/\(name)")
            .validate()
            .responseDecodable { (response: DataResponse<PokemonDetailsResponse, AFError>) in
                do {
                    let result = try response.result.get()
                    
                    completion(.success(result))
                    
                } catch let error {
                    completion(.failure(error))
                }
        }
    }
    
    func getPokemonDetails(index: Int, completion: @escaping (PokemonDetailsResponse) -> Void) {
        getPokemonDetailsRequest(index: index) { (result) in
            
            guard case .success(let details) = result else { return }
            
            completion(details)
        }
    }

}
