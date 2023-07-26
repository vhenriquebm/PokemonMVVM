//
//  ViewController.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import UIKit

class PokemonHomeViewController: UIViewController {
    var delegate: PokemonHomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
    }
    
    private func fetchPokemons(){
        self.delegate = PokemonHomeViewModel()
        self.delegate?.getPokemonsList()
    }
}

