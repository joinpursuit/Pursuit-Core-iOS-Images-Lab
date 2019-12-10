//
//  ComicModel.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct Comic:Decodable {
    var num: Int
    var img: String
}

struct PokemonData: Decodable{
    var cards: Pokemon
}

struct Pokemon: Decodable {
    var name: String
    var imageUrl:String
    var imageUrlHiRes: String
    var types: [String]
    var set: String
    var weaknesses: [Weaknesses]
}

struct Weaknesses: Decodable {
    var type: String
    var value: String
}
