//
//  ProfileViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var ProfileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileTableView.layer.cornerRadius = 40
        ProfileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")

        //        TO DO: Add background image when it is available
        //        profileTableView.backgroundView = UIImageView(image: UIImage(named: <#T##String#>))
    }

}

var mockProfile = [
    ["Nama", "Bambang Sanusi"],
    ["Umur", 43]
]

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        selectedCell.cellTitle.text = (mockProfile[indexPath.row][0] as! String)
        selectedCell.cellDescription.text = mockProfile[indexPath.row][1] as? String
        return selectedCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockProfile.count
    }
    
}
