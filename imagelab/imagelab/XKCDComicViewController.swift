//
//  ViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class XKCDComicViewController: UIViewController {
    
    lazy var comicRange = 1...Int(stepper.maximumValue)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(urlString: "https://xkcd.com/info.0.json")
        
    }
    
    private func loadData(urlString: String) {
        XKCDComic.getXKCDComic(with: urlString) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comic):
                self.loadImage(urlString: comic.img)
                DispatchQueue.main.async {
                    if comic.num > Int(self.stepper.maximumValue) {
                        self.stepper.maximumValue = (Double(comic.num))
                    }
                    self.stepper.value = Double(comic.num)
                }
            }
        }
    }
    
    private func loadImage(urlString: String) {
        UIImage.getImage(urlString: urlString) { (result) in
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

    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        let random = Int.random(in: comicRange)
        loadData(urlString: "https://xkcd.com/\(random)/info.0.json")
        
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
        loadData(urlString: "https://xkcd.com/info.0.json")
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        let stepperValue = Int(sender.value)
        loadData(urlString: "https://xkcd.com/\(stepperValue)/info.0.json")
    }
    
}

extension XKCDComicViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let textInput = textField.text!
        if let num = Int(textInput) {
            if comicRange.contains(num) {
            loadData(urlString: "https://xkcd.com/\(num)/info.0.json")
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Number out of range.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertController, animated: true)
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Entered invalid number", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true)
        }
        return true
    }
}
