//
//  UsersListVC.swift
//  Karooooo
//
//  Created by Sachin on 25/07/22.
//

import UIKit

class UsersListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var userDataSourceArray: [User]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // get users from Api
        getUsers()
    }
    func getUsers() {
        if EventManager.checkForInternetConnection() {
            let apiurlString = Constant.shared.api.baseURL + Constant.shared.api.getUsers
            guard let apiUrl = URL(string: apiurlString) else {return}
            var request = URLRequest(url: apiUrl, timeoutInterval: Double.infinity)
            request.httpMethod = Constant.shared.api.getApi

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data else {return}
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(ApiUser.self, from: data)
                    self.userDataSourceArray = responseModel
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        } else {
            self.showAlert(alertTitle: Constant.shared.appName, alertMessage: "No Internet", buttonTitles: ["Ok"], style: .alert, action: nil)
        }
    }
}

extension UsersListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataSourceArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        userCell.lblCountryName.text = self.userDataSourceArray?[indexPath.row].username
        return userCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userDetail = storyboard?.instantiateViewController(withIdentifier: "UserDetailVC") as? UserDetailVC else {return}
        userDetail.detailUser = self.userDataSourceArray?[indexPath.row]
        navigationController?.pushViewController(userDetail, animated: true)
    }
}
