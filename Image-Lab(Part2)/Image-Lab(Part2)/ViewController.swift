//
//  ViewController.swift
//  Image-Lab(Part2)
//
//  Created by Yuliia Engman on 12/11/19.
//  Copyright © 2019 Yuliia Engman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cards = [Cards]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // searchBar.delegate = self
        // searchPokemon(searchQuary: "name")
        loadPokemons()
        
        navigationItem.title = "Pokemon Cards"
        
    }
    
    func loadPokemons() {
        PokemonAPIClient.getPokemon{[weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    print("error \(appError)")
                }
            case .success(let cards):
                self?.cards = cards.cards
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("could not dequeue PokemonCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(for: card)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
}





