//
//  UserDetailViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView:UIImageView!
    @IBOutlet weak var userLabel:UILabel!
    
    var passedUserObj:User?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        guard let user = passedUserObj else {
            fatalError("failed to pass user obj, check prepare for segue")
        }
        
        userImageView.getImage(with: user.picture.large) { (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self.userImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
                
            case .success(let image):
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
                
            }
        }
        userLabel.text = "Name: \(user.name.returnFullName())\nAge: \(user.dob.age)\nCell:\(user.cell)\nLocation: \(user.location.city), \(user.location.state)"
    }

}
