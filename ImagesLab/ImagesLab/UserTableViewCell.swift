//
//  UserTableViewCell.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
