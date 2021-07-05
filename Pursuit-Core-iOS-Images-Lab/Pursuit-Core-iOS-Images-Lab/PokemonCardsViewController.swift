//
//  PokemonCardsViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class PokemonCardsViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        delegates()
        dataSources()
        loadData()
    }
    
    var pokemons = [Pokemon](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var query = "" {
        didSet{
            pokemons  = pokemons.filter{$0.name.lowercased().contains(query.lowercased())}
        }
    }
    
    func loadData(){
        let endPointString = "https://api.pokemontcg.io/v1/cards"
        PokemonAPI.getCards(endPointURLString: endPointString, completion: { (result) in
            switch result{
            case .failure(let appArror):
                fatalError("Error: \(appArror)")
            case .success(let data):
                self.pokemons = data
            }
        })
    }
    
    func delegates(){
        searchBar.delegate = self
    }
    
    func dataSources(){
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonDVC = segue.destination as? PokemonDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("failed to segue to Detail View Controller")
        }
        
        let pokemon = pokemons[indexPath.row]
        pokemonDVC.passedPokeman = pokemon
    }
}

extension PokemonCardsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("failed to deque")
        }
        
        let pokemon = pokemons[indexPath.row]
        
        let pokemonImageLinkAsString = pokemon.imageUrl
        
        cell.configureCell(with: pokemonImageLinkAsString)
        return cell
    }
}

extension PokemonCardsViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            //searchText is empty here so we get back all the original headlines using our loadData method
            loadData()
            return
        }
        query = searchText
    }
}
