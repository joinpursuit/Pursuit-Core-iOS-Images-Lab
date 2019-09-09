//
//  UserDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Sam Roman on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UsersDetailViewController: UIViewController {
    
    var selectedUser: User!
    var userImage = UIImage() {
        didSet{
            userImageView.image = userImage
        }
    }
    
    
    private func loadImage(urlStr: String){
        ImageHelper.shared.fetchImage(urlString: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.userImage = image
                }
                
            }
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    @IBOutlet weak var cellLabel: UILabel!
    
    
    override func viewDidLoad() {
        loadImage(urlStr: selectedUser.picture.large)
        nameLabel.text = selectedUser.name.fullName()
        ageLabel.text = "Age: \(selectedUser.dob.age)"
        cellLabel.text = selectedUser.cell
        addressLabel.text = selectedUser.location.fullAddress()
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        super.viewDidLoad()
        
        
    }
    
    
}
