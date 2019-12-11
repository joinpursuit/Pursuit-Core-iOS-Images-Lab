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
    
}

//func configureCell() {
//    
//}
//    func configureCell(for country: Country) {
//        let urlString = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
//        flagImage.setImage(with: urlString) { (result) in
//            switch result {
//            case .failure:
//            DispatchQueue.main.async {
//                self.flagImage.image = UIImage(systemName: "photo.fill")
//                }
//            case .success(let flagImage):
//                DispatchQueue.main.async {
//                    self.flagImage.image = flagImage
//                }
//            }
//        }
//        countryLabel.text = country.name
//        capitalLabel.text = "Capital is \(country.capital)"
//        populationLabel.text = "Population is \(String(country.population)) people"
//    }
//    
//}
