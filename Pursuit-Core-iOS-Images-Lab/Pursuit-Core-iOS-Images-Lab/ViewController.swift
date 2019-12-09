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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureStepper()
        updateUI()
    }
    
    var comicValue:Int? {
        didSet{
            updateUI()
        }
    }
    
    lazy var comics = Comic(month: "", num: 0, year: "", title: "", transcript: "", img: "", day: "")
    
    func updateUI(){
        guard let validComicValue = comicValue else { fatalError("Could not load in comicValue")
        }
        stepper.value = Double(validComicValue)
        let comics = ComicAPI.getComics(endPointURLString: "https://xkcd.com/\(validComicValue)/info.0.json") { (result) in
            switch result{
            case .failure(let appError):
                fatalError("Error: \(appError)")
            case .success(let comics):
                self.comics = comics
            }
        }
        imageView.image = UIImage(data: <#T##Data#>)
        
    }
    
    func configureStepper(){
        stepper.minimumValue = 1.0
        stepper.maximumValue = 2239.0
        stepper.stepValue = 1.0
    }
    
//    func getComics() -> [Comic]{
//        guard let validComicValue = comicValue else { fatalError("Could not load in comicValue")
//        }
//        let comics = ComicAPI.getComics(endPointURLString: "https://xkcd.com/\(validComicValue)/info.0.json") { (result) in
//            switch result{
//            case .failure(let appError):
//                fatalError("Error: \(appError)")
//            case .success(let comics):
//                self.comics = [comics]
//            }
//        }
//        return comics
//    }
    
    @IBAction func stepperValChanged(_ sender: UIStepper){
        comicValue = Int(sender.value)
    }
    
    @IBAction func mostRecentButton(){
        
    }
    
    @IBAction func randomButton(){
        
    }


}

