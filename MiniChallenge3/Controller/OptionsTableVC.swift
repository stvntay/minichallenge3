//
//  OptionsTableVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 31/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class OptionsTableVC: UITableViewController {

    var selectedRow = 0
    var selectedMedicineType = -1
    var selectedValue = "1x"
    var valueOptions = ["1x", "2x", "3x"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueOptions.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue = valueOptions[indexPath.row]
        performSegue(withIdentifier: "unwindFromOption", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        cell.textLabel?.text = valueOptions[indexPath.row]
        return cell
    }

}
