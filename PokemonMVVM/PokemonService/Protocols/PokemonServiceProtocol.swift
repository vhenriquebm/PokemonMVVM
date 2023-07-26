//
//  PokemonServiceProtocol.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation

protocol PokemonServiceProtocol {
    func getPokemonsList(completion: @escaping (PokemonCompletion))
}
