//
//  ViewController.swift
//  Images-Lab
//
//  Created by Yuliia Engman on 12/9/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mostRecentButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    var comic: Comic!
    
    
    // we have to create variable for a number of the comic(before didSet)
    var comicNumber = 1 {
        didSet {
            updateComic(comicNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        updateComic(0)
    }
    
    func updateComic(_ number: Int) {
        // let urlString = "https://xkcd.com/614/info.0.json"
        // ComicAPIClient.getComic(with: urlString) { result in
        ComicAPIClient.getComic(for: number) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error is \(appError)")
            case .success(let comic):
                DispatchQueue.main.async {
                    self?.updateImage(for: comic)
                }
            }
        }
    }
    
    func updateImage(for comic: Comic) {
        //let urlString = "https://imgs.xkcd.com/comics/woodpecker.png"
        comicImage.setImage(with: comic.img) { (result) in
            switch result {
            case .failure(let appError):
                print("error is \(appError)")
            case .success(let comicImage):
                DispatchQueue.main.async {
                    self.comicImage.image = comicImage
                }
            }
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        comicNumber = Int(sender.value)
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        updateComic(0)
    }
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
        updateComic(.random(in: 1...2300))
    }
}


extension ViewController: UITextFieldDelegate {
    // this func allows use to use just numbers!
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            return true
        } else if string == "" {
            return true
        } else {
            return false
        }
    }
    
    // allows remove keyboard
    // also updates comicNumber
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        comicNumber = Int(textField.text ?? "") ?? 0
        updateComic(comicNumber)
        textField.resignFirstResponder()
        return true
    }
}

