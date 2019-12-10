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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonDetailViewController {
            destination.pokemonCard = pokemonCards[tableView.indexPathForSelectedRow!.row]
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
        pokemonCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pokemon Cell", for: indexPath)
        cell.textLabel?.text = pokemonCards[indexPath.row].name
        return cell
    }
}
