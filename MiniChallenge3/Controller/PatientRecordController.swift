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
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! PatientRecordTableViewCell
    }
}
