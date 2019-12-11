//
//  ComicModel.swift
//  Images-Lab
//
//  Created by Yuliia Engman on 12/10/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let month: String
    let num: Int
    let year: String
    let img: String
    let title: String
    let day: String
}

