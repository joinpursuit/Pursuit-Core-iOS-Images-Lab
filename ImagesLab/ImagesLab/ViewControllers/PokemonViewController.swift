//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/8/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class PokemonViewController: UITableViewController {
    
    var pokemonCards: [Pokemon]! {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        loadPoke()
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
        return 150
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pokemonCards != nil {
        return pokemonCards.count
        } else { return 0 }
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var currentPoke = pokemonCards[indexPath.row]
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
