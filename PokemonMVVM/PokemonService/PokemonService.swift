//
//  PokemonService.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation
import Alamofire

typealias PokemonCompletion = (Result<[Pokemon], Error>) -> Void

class PokemonService: PokemonServiceProtocol {
    private let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    public func getPokemonsList(completion: @escaping PokemonCompletion) {
        AF.request(url, method: .get ).validate().responseDecodable(of: PokemonRequestList.self) { response in
            
            let status_code = response.response?.statusCode ?? 0
            
            switch response.result {
            case let .success(pokemonList):
                EventLogger.log(path: self.url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                response: response.response,
                                responseValue: pokemonList)
                
                self.getImages(list: pokemonList, completion: { pokemons in
                    completion (pokemons)
                })
                
            case let .failure(error):
                EventLogger.log(path: self.url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                error: error.localizedDescription,
                                response: response.response,
                                responseValue: error)
            }
        }
    }
    
    private func getImages(list: PokemonRequestList, completion: @escaping PokemonCompletion ) {
        var pokemonsList: [Pokemon] = []
        var counter = 1
        
        list.forEach { pokemon in
            if let image = pokemon?.imageURL {
                guard let url = URL(string: image) else { return }
                self.downloadImage(from: url, completion: { values in
                    
                    switch values {
                    case let .success(image):
                        let poke = Pokemon(request: pokemon, image: image)
                        pokemonsList.append(poke)
                        counter += 1
                    case let .failure(erro):
                        print ("Erro ao carregar a imagem: \(erro)")
                    }
                    
                    if counter == list.count {
                        completion(.success(pokemonsList))
                    }
                })
            }
        }
    }
    
    public func downloadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url).validate().responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
