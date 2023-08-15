//
//  HomeViewModel.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation

class PokemonHomeViewModel: PokemonHomeViewModelProtocol {
    var delegate: PokemonServiceProtocol?

    func getPokemonsList(completion: @escaping ([Pokemon]) -> ()) {
        self.delegate =  PokemonService()
        delegate?.getPokemonsList(completion: { result in
            switch result {
            case let .success(pokemons):
                completion(pokemons)
            case  .failure(_):
                print ("erro")
            }
        })
    }
}
