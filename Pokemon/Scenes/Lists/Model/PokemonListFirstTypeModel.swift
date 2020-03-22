//
//  PokemonListFirstTypeModel.swift
//  Pokemon
//
//  Created by Temp on 3/22/20.
//  Copyright © 2020 ymakovet. All rights reserved.
//

import Foundation
import Alamofire

final class PokemonListByTypeModel {
    
    // MARK: - Properties
    
    private(set) var pokemonEntities: [PokemonEntity] = []
    
    private var dataTask: DataRequest?
    private var url: String?
    private var name = ""
    
    // MARK: - Lifecycle
    
    init(url: String) {
        self.url = url
    }
    
    deinit {
        print("deinit: \(self)")
    }
    
    // MARK: - Private methods
    
    private func getPokemonListRequest(completion: @escaping (Result<[PokemonEntity], Error>) -> Void) {
        
        guard let next = url else { return }
        
        dataTask?.cancel()
        dataTask = AF.request(next)
            .validate()
            .responseDecodable { [weak self] (response: DataResponse<PokemonListByTypeResponse, AFError>) in
                guard let `self` = self else { return }
                do {
                    let result = try response.result.get()
                    
                    self.name = result.name ?? ""
                    let pokemon = result.pokemon.map {
                        $0.pokemon
                    }
                    completion(.success(pokemon))
                    
                } catch let err {
                    completion(.failure(err))
                }
        }
    }
}

extension PokemonListByTypeModel: PokemonListModel {
    var title: String {
        return name
    }
    
    func getPokemonList(completion: @escaping () -> Void) {
        
        getPokemonListRequest { [weak self] (result) in
            guard let `self` = self else { return }
            
            guard case .success(let entities) = result else { return }
            
            self.pokemonEntities += entities
            self.url = nil
            completion()
        }
    }
}
