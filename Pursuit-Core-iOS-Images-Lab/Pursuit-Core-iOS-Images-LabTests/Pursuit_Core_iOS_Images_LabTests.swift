//
//  Pursuit_Core_iOS_Images_LabTests.swift
//  Pursuit-Core-iOS-Images-LabTests
//
//  Created by Bienbenido Angeles on 12/9/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import XCTest
@testable import Pursuit_Core_iOS_Images_Lab

class Pursuit_Core_iOS_Images_LabTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndPoint2() {
        //arrange
        //make this string url friendly
        let endPointString = "https://api.pokemontcg.io/v1/cards"
        let exp = XCTestExpectation(description: "searches found")
        
        //act
        NetworkHelper.shared.performDataTask(with: endPointString) { (result) in
            switch result{
            case .failure(let appError):
                XCTFail("App Err: \(appError)")
            case .success(let data):
                exp.fulfill()
                //assert
                XCTAssertGreaterThan(data.count, 60000, "Data should be greater than \(data.count)")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    func testVC2SearchFunc(){
        //arrange
        var pokemons = [Pokemon]()
        let endPointString = "https://api.pokemontcg.io/v1/cards"
        let exp = XCTestExpectation(description: "searches found")
        PokemonAPI.getCards(endPointURLString: endPointString, completion: { (result) in
            switch result{
            case .failure(let appArror):
                fatalError("Error: \(appArror)")
            case .success(let data):
                pokemons = data
            }
        })
        wait(for: [exp], timeout: 10.0)

        
        let expectedCountOfPokemons = 19
        
        //act
        let countOfPokemons = pokemons.filter{$0.name.lowercased().contains("H".lowercased())}.count
        //assert
        XCTAssertEqual(expectedCountOfPokemons, countOfPokemons, "Expected \(expectedCountOfPokemons) pokemons, instead of \(countOfPokemons)")

    }
}
