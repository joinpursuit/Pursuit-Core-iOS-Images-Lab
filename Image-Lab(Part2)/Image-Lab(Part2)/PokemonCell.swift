//
//  PokemonCell.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    //private var urlString = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //empty out the image view = set to nil
        pokemonImage.image = nil
    }
    
    
    func configureCell(for cards: Cards) {
        
        pokemonImage.setImage(with: cards.imageUrlHiRes) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.pokemonImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                // coming from a background thread
                // dispatch back to the main thread to update the UI
                DispatchQueue.main.async {
                    self?.pokemonImage.image = image
                }
            }
        }
    }
}


