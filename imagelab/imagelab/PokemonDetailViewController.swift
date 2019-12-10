//
//  DetailViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    var pokemonCard: PokemonCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
    }
    
    private func loadImage() {
        UIImage.getImage(urlString: pokemonCard.imageUrlHiRes) { (result) in
            switch result {
            case .failure(let error):
                print("Error getting image from url: \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private func setLabels() {
        nameLabel.text = pokemonCard.name
        typeLabel.text = pokemonCard.types?.joined(separator: ", ") ?? ""
        weaknessLabel.text = pokemonCard.weaknesses?.map{$0.type}.joined(separator: ", ")
        setLabel.text = pokemonCard.set
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
