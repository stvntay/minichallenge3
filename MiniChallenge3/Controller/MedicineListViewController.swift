//
//  CreateRecordViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 25/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class MedicineListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var medicineList: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicineList", for: indexPath) as! MedicineListTableViewCell
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0)]
        self.medicineList.rowHeight = 210
        medicineList.delegate = self
        medicineList.dataSource = self
        medicineList.register(UINib(nibName: "MedicineListTableViewCell", bundle: nil), forCellReuseIdentifier: "medicineList")
//        navBar.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "add-icon")?.withRenderingMode(.alwaysOriginal),
//            landscapeImagePhone: UIImage(named: "add-icon"),
//            style: .plain,
//            target: self,
//            action: #selector(onCreateMedicineTapped)
//        )
        // Do any additional setup after loading the view.
    }

    @objc func onCreateMedicineTapped() {
        
    }
}
