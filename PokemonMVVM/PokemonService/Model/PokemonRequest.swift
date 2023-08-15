//
//  Pokemon.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation

struct PokemonRequest: Codable {
    let attack, defense: Int?
    let description: String?
    let evolutionChain: [EvolutionChainRequest]?
    let height, id: Int?
    let imageURL: String?
    let name, type: String?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case attack, defense, description, evolutionChain, height, id
        case imageURL = "imageUrl"
        case name, type, weight
    }
}

struct EvolutionChainRequest: Codable {
    let id, name: String?
}

typealias PokemonRequestList = [PokemonRequest?]

struct Pokemon: Codable {
    let request: PokemonRequest?
    let image: Data?
}


