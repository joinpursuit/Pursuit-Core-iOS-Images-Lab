//
//  ViewController.swift
//  Images-Lab
//
//  Created by Yuliia Engman on 12/9/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mostRecentButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    var comic: Comic!
    
    var comicNumber = 1 {
        didSet {
            updateComic(comicNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateComic(1)
    }
    
    func updateComic(_ number: Int) {
        // let urlString = "https://xkcd.com/614/info.0.json"
        // ComicAPIClient.getComic(with: urlString) { result in
        ComicAPIClient.getComic(for: number) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print
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
            case .failure:
                DispatchQueue.main.async {
                    self.comicImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let comicImage):
                DispatchQueue.main.async {
                    self.comicImage.image = comicImage
                }
            }
        }
    }
    
    //  func updateImage(for comic: Comic) {
    //    // update textview
    //    comivImageView.getImage(with: comic.img) { (result) in
    //      switch result {
    //      case .failure(let appError):
    //        print("error is \(appError)")
    //      case .success(let image):
    //        DispatchQueue.main.async {
    //          self.comivImageView.image = image
    //        }
    //
    //      }
    //    }
    //  }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        comicNumber = Int(sender.value)
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func recentButtonPressed(_ sender: UIButton) {
    }
}



