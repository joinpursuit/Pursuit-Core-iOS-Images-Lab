//
//  String+Extensions.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

extension String{
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
