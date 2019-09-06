//
//  ViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/5/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var comicImage: UIImage? {
        didSet {
            comicView.image = self.comicImage
        }
    }
    
    var comic: Comic! {
        didSet {
            loadImage()
        }
    }
    
    var comicNum = 0 {
        didSet {
            loadData()
        }
    }
    
   
    func changeComicNum(){
        comicNum += Int(stepperOut.value)
    }
    
    
    
    @IBOutlet weak var comicView: UIImageView!
    
    
    @IBOutlet weak var stepperOut: UIStepper!
    
    
    @IBOutlet weak var textFieldOut: UITextField!
    
    
    @IBAction func mostRecentButton(_ sender: Any) {
    }
    
    
    @IBAction func randomButton(_ sender: Any) {
    }
    
    private func loadImage(){
        ImageHelper.shared.fetchImage(urlString: comic?.img ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                self.comicImage = image
                }

            }
        }
    }

    
    private func loadData() {
        Comic.getComic(comicNum: nil ) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let comicInfo):
                    self.comic = comicInfo
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    



}

