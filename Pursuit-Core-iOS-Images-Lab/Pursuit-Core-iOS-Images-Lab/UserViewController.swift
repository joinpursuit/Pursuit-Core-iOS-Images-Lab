//
//  UserViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Bienbenido Angeles on 12/10/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        let endPointString = "https://randomuser.me/api/?results=50"
        UsersAPI.getUsers(endPointURLString: endPointString) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                print(appError)
            case .success(let users):
                self?.users = users
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDVC = segue.destination as? UserDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { fatalError("failed to segue, check segue destination or if a vc conforms to the segue's destination") }
        
        let user = users[indexPath.row]
        userDVC.passedUserObj = user
    }

}
extension UserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { fatalError("check reuse identifier on cell") }
        let user = users[indexPath.row]
        let userLink = user.picture.thumbnail
        
        cell.configureCell(with: userLink, user: user)
        return cell
    }
}
