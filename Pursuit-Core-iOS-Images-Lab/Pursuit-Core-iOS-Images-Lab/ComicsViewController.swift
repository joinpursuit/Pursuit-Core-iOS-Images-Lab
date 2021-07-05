//
//  ViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class ComicsViewController: UIViewController {
    
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
        //updateUI()
        //comics.img = "https://www.maropost.com/wp-content/uploads/2019/06/The-Welcome-Email_06042019-01.jpg"
        loadData()
    }
    
    var comicValue:String = ""{
        didSet{
            updateUI()
            //loadData()
        }
    }
    
    var maxComicValue:Int?
    var comics = Comic(num: 1, img: "")


    func updateUI(){
        
        if comicValue == "0"{
            comicValue = ""
        }
        stepper.value = Double(comicValue) ?? 1.0
        ComicAPI.getComics(endPointURLString: "https://xkcd.com/\(comicValue)/info.0.json") { (result) in
            switch result{
            case .failure(let appError):
                fatalError("Error: \(appError)")
            case .success(let comics):
                self.comics = comics
                NetworkHelper.shared.performDataTask(with: comics.img) { (result) in
                    switch result{
                    case .failure(let appError):
                        fatalError("Error: \(appError)")
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.stepper.value = Double(self.comicValue) ?? 0.0
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
    func loadData(){
        ComicAPI.getComics(endPointURLString: "https://xkcd.com/info.0.json") { (result) in
            switch result{
            case .failure(let appError):
                fatalError("Error: \(appError)")
            case .success(let comics):
                self.comics = comics
                NetworkHelper.shared.performDataTask(with: comics.img) { (result) in
                    switch result{
                    case .failure(let appError):
                        fatalError("Error: \(appError)")
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.stepper.value = Double(self.comicValue) ?? 0.0
                            self.imageView.image = UIImage(data: data)
                            self.maxComicValue = self.comics.num
                            self.stepper.maximumValue = Double(self.comics.num)
                        }
                    }
                }
            }
        }
    }
    
    func delegations(){
        textField.delegate = self
        textField.placeholder = "Enter an comic book value"
    }
    
    func configureStepper(){
        stepper.minimumValue = 1.0
       // stepper.maximumValue = Double(maxComicValue)
        stepper.stepValue = 1.0
    }
    
    
    @IBAction func stepperValChanged(_ sender: UIStepper){
        comicValue = String(Int(sender.value))
    }
    
    @IBAction func mostRecentButton(sender: UIButton){
        comicValue = ""
    }
    
    @IBAction func randomButton(sender:UIButton){
        comicValue = String(Int.random(in: 1...maxComicValue!))
    }


}

extension ComicsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false
        }
        
        for char in text{
            if !char.isNumber{
                return false
            }
        }
        
        comicValue = String(text)
        if comicValue == "0"{
            comicValue = ""
        }
        let stringComicValueAsInt = Int(comicValue) ?? 0
        if stringComicValueAsInt > maxComicValue!{
            return false
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
