//
//  PokemonCollectionViewCell.swift
//  PokemonMVVM
//
//  Created by Vitor Henrique Barreiro Marinho on 25/07/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    static let identifier = "PokemonCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.masksToBounds = true
    }
    
    public func render(with name: String, and image: Data) {
        self.pokemonName.text = name
        self.pokemonImage.image = UIImage(data: image)
    }
}
