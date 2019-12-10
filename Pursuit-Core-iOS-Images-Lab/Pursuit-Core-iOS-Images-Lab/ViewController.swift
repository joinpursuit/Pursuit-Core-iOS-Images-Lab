//
//  ViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var textField:UITextField!
    @IBOutlet weak var stepper:UIStepper!
    @IBOutlet weak var mostRecentButton:UIButton!
    @IBOutlet weak var randomButton:UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegations()
        configureStepper()
        updateUI()
    }
    
    var comicValue:String? = "1"{
        didSet{
            updateUI()
        }
    }
    
    var maxComicValue = 2239
    
    var comics = Comic(num: 1, img: "")
    
    func updateUI(){
        guard let validComicValue = comicValue else { fatalError("Could not load in comicValue")
        }
        stepper.value = Double(validComicValue) ?? 1.0
        ComicAPI.getComics(endPointURLString: "https://xkcd.com/\(validComicValue)/info.0.json") { (result) in
            switch result{
            case .failure(let appError):
                fatalError("Error: \(appError)")
            case .success(let comics):
                self.comics = comics
            }
        }
        
        NetworkHelper.shared.performDataTask(with: comics.img) { (result) in
            switch result{
            case .failure(let appError):
                fatalError("Error: \(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }

    }
    
    func delegations(){
        textField.delegate = self
    }
    
    func configureStepper(){
        stepper.minimumValue = 1.0
        stepper.maximumValue = 2239.0
        stepper.stepValue = 1.0
    }
    
    
    @IBAction func stepperValChanged(_ sender: UIStepper){
        comicValue = String(Int(sender.value))
    }
    
    @IBAction func mostRecentButton(sender: UIButton){
        comicValue = ""
    }
    
    @IBAction func randomButton(sender:UIButton){
        comicValue = String(Int.random(in: 1...2239))
    }


}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false
        }
        
        for char in text{
            if !char.isNumber{
                return false
            }
        }
        
        comicValue = String(text)
        let stringComicValueAsInt = Int(comicValue!)!
        if stringComicValueAsInt > maxComicValue{
            return false
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
