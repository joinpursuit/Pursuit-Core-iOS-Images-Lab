//
//  PokeDetailVCViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PokeDetailVCViewController: UIViewController {

    var selectedPoke: Pokemon!
    
    var pokeImage: UIImage! {
        didSet {
            cardImageView.image = pokeImage
        }
    }
    
    private func loadImage(){
        ImageHelper.shared.fetchImage(urlString: selectedPoke.imageUrlHiRes ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.pokeImage = image
                }
                
            }
        }
    }
    
    func setLabels(){
        if selectedPoke != nil {
        nameLabel.text = selectedPoke.name
        setLabel.text = selectedPoke.set
        if selectedPoke.weaknesses != nil {
        weaknessLabel.text = String("Weakness: \(selectedPoke.weaknesses!)")
        } else {
            weaknessLabel.text = "Weakness: N/A"
        }
            if selectedPoke.types != nil {
            typesLabel.text = String("Types: \(selectedPoke.types!)")
            } else {
                typesLabel.text = "Types: N/A"
            }
        }
    }
        
    
  
    
    override func viewDidLoad() {
        setLabels()
        loadImage()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var weaknessLabel: UILabel!
    
    
    @IBOutlet weak var setLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
