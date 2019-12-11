//
//  RandomUserDetailViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class RandomUserDetailViewController: UIViewController {
    
    var randomUser: RandomUser!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        setLabels()
        // Do any additional setup after loading the view.
    }
    
    private func loadImage() {
        UIImage.getImage(urlString: randomUser.picture.large) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private func setLabels() {
        nameLabel.text = "\(randomUser.name.first) \(randomUser.name.last)"
        ageLabel.text = String(randomUser.dob.age)
        phoneLabel.numberOfLines = 2
        phoneLabel.text = "Home: \(randomUser.phone) \nCell: \(randomUser.cell)"
        locationLabel.text = "\(randomUser.location.city), \(randomUser.location.state)"
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
