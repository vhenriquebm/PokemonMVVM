//
//  ViewController.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import UIKit

class PokemonHomeViewController: UIViewController {
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    var delegate: PokemonHomeViewModel?
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemons()
        configureCollectionView()
    }
    
    private func fetchPokemons(){
        self.delegate = PokemonHomeViewModel()
        self.delegate?.getPokemonsList(completion: { pokemons in
            
            DispatchQueue.main.async {
                self.pokemons = pokemons
                self.pokemonCollectionView.reloadData()
            }
        })
    }
    
    private func configureCollectionView() {
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        
        pokemonCollectionView.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
}

extension PokemonHomeViewController: UICollectionViewDelegate {
    
}

extension PokemonHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = pokemonCollectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell {
            
            let pokemon = pokemons[indexPath.row]
            
            cell.render(with: pokemon.request?.name ?? "", and: pokemon.image ?? Data())
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension PokemonHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
