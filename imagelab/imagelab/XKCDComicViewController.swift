//
//  ViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class XKCDComicViewController: UIViewController {
    
    let xkcdComic = XKCDComic.getXKCDComic()
    lazy var comicRange = 0...xkcdComic.num

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func randomButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIButton) {
    }
}

