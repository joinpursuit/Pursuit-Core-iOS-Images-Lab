//
//  ComicModel.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct Comic:Decodable {
    var month: String
    var num: Int
    var year: String
    var title: String
    var transcript: String
    var img: String
    var day: String
}
