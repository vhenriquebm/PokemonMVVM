//
//  PokemonService.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import Foundation
import Alamofire

typealias PokemonCompletion = (Result<PokemonList, Error>) -> Void

class PokemonService: PokemonServiceProtocol {
    private let url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    public func getPokemonsList(completion: @escaping (PokemonCompletion)) {
        
        AF.request(url, method: .get ).validate().responseDecodable(of: PokemonList.self) { response in
            
            let status_code = response.response?.statusCode ?? 0
            
            switch response.result {
            case let .success(pokemonList):
                completion(.success(pokemonList))
                EventLogger.log(path: self.url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                response: response.response,
                                responseValue: pokemonList)
                
            case let .failure(error):
                completion(.failure(error))
                EventLogger.log(path: self.url,
                                statusCode: status_code,
                                headers: response.request?.headers.dictionary ?? [:],
                                error: error.localizedDescription,
                                response: response.response,
                                responseValue: error)
            }
        }
    }
    
    
    
}
