//
//  PokemonHomeViewModelProtocol.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation

protocol PokemonHomeViewModelProtocol {
    func getPokemonsList(completion: @escaping ([Pokemon]) -> ())
}
