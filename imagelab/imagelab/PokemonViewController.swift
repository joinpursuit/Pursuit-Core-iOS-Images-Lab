//
//  PokemonViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var pokemonCards = [PokemonCard]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var filteredPokemonCards: [PokemonCard] {
        guard let query = searchQuery else { return pokemonCards }
        return query == "" ? pokemonCards : pokemonCards.filter{$0.name.lowercased().contains(query.lowercased())}
    }
    
    private var searchQuery: String? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        DispatchQueue.main.async {
            PokemonCard.loadCards { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let cards):
                    self.pokemonCards = cards
                }
            }
        }
    }
    
    private func configureViews() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailViewController {
            destination.pokemonCard = filteredPokemonCards[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension PokemonViewController: UITableViewDelegate {}
extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemonCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon Cell", for: indexPath)
        cell.textLabel?.text = filteredPokemonCards[indexPath.row].name
        return cell
    }
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchBar.text
    }
}
