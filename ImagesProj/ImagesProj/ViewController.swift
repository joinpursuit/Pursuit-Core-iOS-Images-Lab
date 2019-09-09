//
//  ViewController.swift
//  ImagesProj
//
//  Created by Kevin Natera on 9/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        updateImage(number: Int(sender.value))
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        updateImage(number: 2199)
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        randomImage()
    }
    
    var comic: Comic? {
        didSet {
            loadImage()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let num = Int(textFieldOutlet.text!) {
            if num <= 2199 {
            textFieldOutlet.resignFirstResponder()
            stepperOutlet.value = Double(num)
            updateImage(number: num)
            return true
        }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage(number: 2100)
        textFieldOutlet.delegate = self
    }
    
  
    private func loadImage() {
        ImageHelper.shared.fetchImage(urlString: comic!.img ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.imageOutlet.image = image
                }
            }
    }
    
}
    private func updateImage(number: Int?){
        Comic.getComic(userNum: number){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comics):
                DispatchQueue.main.async {
                    self.comic = comics
                }
            }
        }
    }
    
    func randomImage() {
        let random = Int.random(in: 1...2199)
        stepperOutlet.value = Double(random)
        updateImage(number: random)
    }
}





