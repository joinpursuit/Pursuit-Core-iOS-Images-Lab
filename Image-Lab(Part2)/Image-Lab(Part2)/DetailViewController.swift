//
//  DetailViewController.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var weaknessesLable: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    
    var card: Cards?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let onePokemon = card else {
            fatalError("could not get object from prepare for segue")
        }
        nameLabel.text = "Pokemon's name: \(onePokemon.name)"
        typesLabel.text = "Pokemon's types: \(onePokemon.types?.first ?? "no types")"
        weaknessesLable.text = "Weaknesses of type: \(onePokemon.weaknesses?[0].type ?? "") and of value: \(onePokemon.weaknesses?[0].value ?? "")"
        setLabel.text = "Pokemon's set: \(onePokemon.set)"
        
        imageView.setImage(with: onePokemon.imageUrl) {[weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let pokemonImage):
                DispatchQueue.main.async {
                    self?.imageView.image = pokemonImage
                }
            }
        }
    }
}

//weaknessesLabel.text = "\(pokemon.weaknesses?[0].type ?? "") and \(pokemon.weaknesses?[0].value ?? "")"
//
//or
//weaknessesLabel.text = pokemon.weaknesses?[0].type
//in short)

