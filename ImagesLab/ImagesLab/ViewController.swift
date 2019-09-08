//
//  ViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/5/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var comic: Comic! {
        didSet {
            loadImage()
}
    }
    var comicImage: UIImage? {
        didSet {
            comicView.image = self.comicImage
            comicNumLabel.text = "# \(comic.num)"
            
        }
    }
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var comicNumLabel: UILabel!
    @IBOutlet weak var comicView: UIImageView!
    @IBOutlet weak var stepperOut: UIStepper!
    @IBOutlet weak var textFieldOut: UITextField!
    
    @IBAction func stepperAct(_ sender: UIStepper) {
        loadData(comicNum: Int(sender.value))
    }
    @IBAction func mostRecentButton(_ sender: Any) {
        loadData(comicNum: nil)
    }
    @IBAction func randomButton(_ sender: Any) {
        let random = Int.random(in: 1...2199)
        stepperOut.value = Double( random)
        loadData(comicNum: random)
    }
    //MARK: - Network Methods
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
    private func loadData(comicNum: Int? ) {
        Comic.getComic(comicNum: comicNum ) { (result) in
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
    private func setUp(){
        let random = Int.random(in: 1...2199)
        stepperOut.value = Double( random)
        loadData(comicNum: random)
    }
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        setUp()
        textFieldOut.delegate = self
        super.viewDidLoad()
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userInput = Int((textField.text)!){
            loadData(comicNum: userInput)
            stepperOut.value = Double(userInput)
            return true
        }
        return false
    }
}
