//
//  CountryListVC.swift
//  Karooooo
//
//  Created by Sachin on 24/07/22.
//

import UIKit

class CountryListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var countryList = [String]()
    var countryNameCallback: ((_ name: String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CountryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        countryCell.lblCountryName.text = countryList[indexPath.row]
        return countryCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countryNameCallback?(countryList[indexPath.row])
        self.dismiss(animated: true)
    }
}

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCountryName: UILabel!
}
