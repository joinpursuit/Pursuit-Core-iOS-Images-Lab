//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PokemonViewController: UITableViewController {
    
    var pokemonCards = [Pokemon]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchString: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchResults: [Pokemon]{
        get {
            guard let searchString = searchString else {
                return pokemonCards
                
            }
            guard searchString != "" else {
                return pokemonCards
            }
            return pokemonCards.filter{$0.name.contains(searchString)}
            
        }
    }

    override func viewDidLoad() {
        loadPoke()
        searchBar.delegate = self
        super.viewDidLoad()

 
    }
    
    private func loadPoke(){
        Cards.loadPoke { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let cards):
                    self.pokemonCards = cards
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return searchResults.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPoke = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as! PokeCell
        ImageHelper.shared.fetchImage(urlString: currentPoke.imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.pokemonImage.image = image
                }
                
            }
        }

        return cell
    }
 

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier in segue")
        }
        switch segueIdentifier {
        case "pokeSegue":
            guard let detailVC = segue.destination as? PokeDetailVCViewController
                else {
                    fatalError("Unexpected segue")}
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                fatalError("No row selected")
            }
            detailVC.selectedPoke = searchResults[selectedIndexPath.row]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    

}

extension PokemonViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchBar.text
    }
    
}

