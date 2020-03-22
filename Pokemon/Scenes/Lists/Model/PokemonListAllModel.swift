//
//  PokemonListAllModel.swift
//  Pokemon
//
//  Created by Ruslan on 21.03.2020.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation
import Alamofire

final class PokemonListAllModel {
    
    // MARK: - Properties
    
    private(set) var pokemonEntities: [PokemonEntity] = []
    
    private var dataTask: DataRequest?
    private var nextPageURL: String? = "https://pokeapi.co/api/v2/pokemon"
    
    // MARK: - Private methods
    
    private func getPokemonListRequest(completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        
        guard let next = nextPageURL else { return }
        
        dataTask?.cancel()
        dataTask = AF.request(next)
            .validate()
            .responseDecodable { (response: DataResponse<PokemonListResponse, AFError>) in
                do {
                    let result = try response.result.get()
                    
                    completion(.success(result))
                    
                } catch let err {
                    completion(.failure(err))
                }
        }
        
    }
    
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
}

extension PokemonListAllModel: PokemonListModel {
    
    var title: String {
        return "All"
    }

    func getPokemonList(completion: @escaping () -> Void) {
        
        getPokemonListRequest { [weak self] (result) in
            guard let `self` = self else { return }
            
            guard case .success(let entities) = result else { return }
            
            self.pokemonEntities += entities.results
            self.nextPageURL = entities.next
            
            completion()
        }
    }

}
