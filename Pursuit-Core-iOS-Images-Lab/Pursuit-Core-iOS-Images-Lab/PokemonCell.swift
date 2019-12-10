//
//  PokemonCell.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView:UIImageView!
    
    private var urlString = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
    }
    
    func configureCell(with urlString: String){
        self.urlString = urlString
        pokemonImageView.getImage(with: urlString) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.urlString == urlString{
                        self?.pokemonImageView.image = image
                    }
                }
            }
        }
    }

}
