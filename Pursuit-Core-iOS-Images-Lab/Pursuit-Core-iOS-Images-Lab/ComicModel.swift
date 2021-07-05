//
//  ComicModel.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

//Comics
struct Comic:Decodable {
    var num: Int
    var img: String
}

//Pokemon
struct PokemonData: Decodable{
    var cards: [Pokemon]
}

struct Pokemon: Decodable {
    var name: String
    var imageUrl:String
    var imageUrlHiRes: String
    var types: [String]?
    var set: String
    var weaknesses: [Weaknesses]?
}

struct Weaknesses: Decodable {
    var type: String
    var value: String
}

//Users
struct UserData: Decodable {
    let results: [User]
}

struct User: Decodable {
    var name: Name
    let location: Location
    let dob: DOB
    let email: String
    let cell: String
    let picture: Picture
}

struct Name: Decodable {
    var first: String
    var last: String
}

struct Location: Decodable {
    let city: String
    let state: String
}

struct DOB:Decodable {
    var age: Int
}

struct Picture: Decodable{
    let large: String
    let medium: String
    let thumbnail: String
}

extension Name {
    
    func returnFullName() -> String{
        var firstName = self.first
        var lastName = self.last
        
        firstName.capitalizeFirstLetter()
        lastName.capitalizeFirstLetter()
        
        let fullName = "\(firstName) \(lastName)"
        return fullName
    }
}
