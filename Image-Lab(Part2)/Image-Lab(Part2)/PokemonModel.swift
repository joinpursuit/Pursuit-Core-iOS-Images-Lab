//
//  PokemonModel.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import Foundation

struct PokemonData: Decodable {
    let cards: [Cards]
}

struct Cards: Decodable {
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let types: [String]?
    let weaknesses: [Weaknesses]?
    let set: String
}

struct Weaknesses: Decodable {
    let type: String
    let value: String
}

//{
//"cards": [
//    {
//        "id": "dp6-90",
//        "name": "Cubone",
//        "nationalPokedexNumber": 104,
//        "imageUrl": "https://images.pokemontcg.io/dp6/90.png",
//        "imageUrlHiRes": "https://images.pokemontcg.io/dp6/90_hires.png",
//        "types": [
//            "Fighting"
//        ],
//        "supertype": "Pokémon",
//        "subtype": "Basic",
//        "hp": "60",
//        "retreatCost": [
//            "Colorless"
//        ],
//        "convertedRetreatCost": 1,
//        "number": "90",
//        "artist": "Kagemaru Himeno",
//        "rarity": "Common",
//        "series": "Diamond & Pearl",
//        "set": "Legends Awakened",
//        "setCode": "dp6",
//        "attacks": [
//            {
//                "cost": [
//                    "Colorless"
//                ],
//                "name": "Headbutt",
//                "text": "",
//                "damage": "10",
//                "convertedEnergyCost": 1
//            },
//            {
//                "cost": [
//                    "Fighting",
//                    "Colorless"
//                ],
//                "name": "Bonemerang",
//                "text": "Flip 2 coins. This attack does 20 damage times the number of heads.",
//                "damage": "20×",
//                "convertedEnergyCost": 2
//            }
//        ],
//        "resistances": [
//            {
//                "type": "Lightning",
//                "value": "-20"
//            }
//        ],
//        "weaknesses": [
//            {
//                "type": "Water",
//                "value": "+10"
//            }
//        ]
//    },
