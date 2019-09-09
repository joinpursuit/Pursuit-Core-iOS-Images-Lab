//
//  UserTableViewController.swift
//  ImagesLab
//
//  Created by Sam Roman on 9/9/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    var userData = [User]() {
        didSet {
        tableView.reloadData()
    }
    }
    
    
    
    private func loadData(){
        UserInfo.getUser { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.userData = data
                }
            }
        }
    }
    
   
   
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        if userData.count != 0 {
        let user = self.userData[indexPath.row]
        cell.nameLabel.text = user.name.fullName()
            cell.ageLabel.text = "\(user.dob.age) years old."
            cell.numberLabel.text = "Cell: \(user.phone)"
        ImageHelper.shared.fetchImage(urlString: user.picture.thumbnail ) { (result) in
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
            cell.userThumbnail.image = image
        }
                    
        }
}
            

}
        return cell
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier in segue")
        }
        switch segueIdentifier {
        case "userSegue":
            guard let detailVC = segue.destination as? UsersDetailViewController
                else {
                    fatalError("Unexpected segue")}
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                fatalError("No row selected")
            }
            detailVC.selectedUser = userData[selectedIndexPath.row]
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    
}
