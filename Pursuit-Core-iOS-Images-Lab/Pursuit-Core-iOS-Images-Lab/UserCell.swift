//
//  UserCell.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/11/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userimageView:UIImageView!
    @IBOutlet weak var userinfoLabel:UILabel!
    
    private var urlString = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userimageView.image = nil
    }
    
    func configureCell(with urlString: String? = nil, user: User){
        guard let urlStr = urlString else { return }
        
        self.urlString = urlStr
        userimageView.getImage(with: urlStr) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.userimageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                if self?.urlString == urlString{
                    DispatchQueue.main.async {
                        self?.userimageView.image = image
                    }
                }
            }
        }
        
        userinfoLabel.text = "Name: \(user.name.returnFullName())\nAge: \(user.dob.age)\nCell: \(user.cell)"
    }

}
