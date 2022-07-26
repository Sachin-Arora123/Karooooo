//
//  UsersListVC.swift
//  Karooooo
//
//  Created by Sachin on 25/07/22.
//

import UIKit

class UsersListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getUsers(){
        
    }
}

extension UsersListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        userCell.lblCountryName.text = "text"
        return userCell
    }
}
