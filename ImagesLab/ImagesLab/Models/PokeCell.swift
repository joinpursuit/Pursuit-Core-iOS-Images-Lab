//
//  PokeCell.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PokeCell: UITableViewCell {
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
