//
//  HomeViewModel.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation

class PokemonHomeViewModel: PokemonHomeViewModelProtocol {
    var delegate: PokemonServiceProtocol?

    func getPokemonsList() {
        self.delegate =  PokemonService()
        delegate?.getPokemonsList(completion: { pokemons in
            print (pokemons)
        })
    }
}
