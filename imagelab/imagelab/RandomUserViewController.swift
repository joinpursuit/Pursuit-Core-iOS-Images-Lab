//
//  RandomUserViewController.swift
//  imagelab
//
//  Created by Ahad Islam on 12/10/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class RandomUserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var randomUsers = [RandomUser]() {
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
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadData() {
        RandomUser.loadUsers { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let users):
                self.randomUsers = users
            }
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

extension RandomUserViewController: UITableViewDelegate {}
extension RandomUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Random User Cell", for: indexPath) as? RandomUserCell else {
            fatalError("Error downcasting cell")
        }
        
        UIImage.getImage(urlString: randomUsers[indexPath.row].picture.thumbnail) { (result) in
            switch result {
            case .failure(let error):
                print ("Error getting image \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        
        cell.ageLabel.text = String(randomUsers[indexPath.row].dob.age)
        cell.cellLabel.text = randomUsers[indexPath.row].cell
        cell.nameLabel.text = "\(randomUsers[indexPath.row].name.first) \(randomUsers[indexPath.row].name.last)"
        return cell
    }
}
