//
//  PokemonDetailViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var passedPokeman:Pokemon?
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var label:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI(){
        guard let pokemon = passedPokeman else {
            fatalError("Check prepare(for: segue)")
        }
        imageView.getImage(with: pokemon.imageUrlHiRes) {[weak self](result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    //if self?.passedPokeman?.imageUrl == pokemon.imageUrl{
                        self?.imageView.image = image
                    //}
                }
            }
        }
        label.text = "Name: \(pokemon.name)\nType: \(pokemon.types?.first ?? "N/A")\nWeaknesses:\n\tType:  \(pokemon.weaknesses?.first?.type ?? "N/A")\n\tValue: \(pokemon.weaknesses?.first?.value ?? "N/A")\nSet: \(pokemon.set)"
    }
}
