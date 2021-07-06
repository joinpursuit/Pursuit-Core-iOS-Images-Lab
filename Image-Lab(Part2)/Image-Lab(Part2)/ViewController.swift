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
    
    
    var searchQuery = "" {
        didSet {
            searchPokemon(searchQuary: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemons()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        //searchPokemon(searchQuary: cards.description)
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
                DispatchQueue.main.async {
                    self?.cards = cards
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not segue to second VC")
        }
        let card = cards[indexPath.row]
        detailVC.card = card
    }
    
    func searchPokemon(searchQuary: String) {
        print(searchQuery.lowercased())
        cards = cards.filter {$0.name.lowercased().contains(searchQuery.lowercased()) }
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

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            print("missing search text")
            loadPokemons()
            return
        }
        
        searchQuery = searchText
        print(searchText)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
}





