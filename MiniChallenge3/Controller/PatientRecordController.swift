//
//  PatientRecord.swift
//  MiniChallenge3
//
//  Created by Yosia on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class PatientRecordController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var patientRecordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patientRecordTableView.register(UINib(nibName: "PatientRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientRecordTableViewCell")
        // Do any additional setup after loading the view.
    }

    
}

extension PatientRecordController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Configure number of row
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientRecordTableViewCell", for: indexPath) as! PatientRecordTableViewCell
        
        // Configure the cell’s contents here
        
        return cell
    }
}
