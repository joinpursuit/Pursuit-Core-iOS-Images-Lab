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
    }

}
extension UserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
