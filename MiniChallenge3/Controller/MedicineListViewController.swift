//
//  CreateRecordViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 25/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class MedicineListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var medicineList: UITableView!
    
    var medicineData : [MedicineData] = []
    
    var deletedIndex: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicineList", for: indexPath) as! MedicineListTableViewCell
        cell.medicineName.text = medicineData[indexPath.row].medicineName
        cell.medicineTime.text = medicineData[indexPath.row].medicineTime
        cell.medicineDescription.text = medicineData[indexPath.row].medicineDesc
        cell.medicineAmount.text = medicineData[indexPath.row].medicineDose
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.medicineList.rowHeight = 210
        medicineList.delegate = self
        medicineList.dataSource = self
        medicineList.register(UINib(nibName: "MedicineListTableViewCell", bundle: nil), forCellReuseIdentifier: "medicineList")
        
        navigationItem.title = "Obat"
        let addImg = UIImage(named: "add-icon")
        let addButton = UIBarButtonItem(image: addImg, style: .plain, target: self, action: #selector(addMedicinePage))
       
        navigationItem.rightBarButtonItem = addButton
        
        clearNavigationBar()
        getData()
    }
    
    func clearNavigationBar(){
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    @objc func addMedicinePage(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "AddMedicine", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addMedicine") as! UIViewController
        self.navigationController?.pushViewController(vc, animated: true)

//        let vc = AddMedicineVC()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData(){
        guard let userID = UserDefaults.standard.string(forKey: "userID") else{
            return
        }
        print(userID)
        
        
        MedicineModel.shared.loadMedicineData(userRN: userID) { (result) in
            
            for i in result {
                guard let id = i.recordID.recordName as? String else{
                    
                    return
                }
                
                guard let getName =  i["namaObat"] as? String else{
                    return
                }
                
                guard let getDesc = i["deskripsiObat"] as? String else{
                    return
                }
                
                guard let getDose = i["dosisObat"]  as? String else{
                    return
                }
                
                guard let getTime = i["setelahSebelumMakan"]  as? String else{
                    return
                }
                
                guard let getCategory = i["kategori"] as? String else{
                    return
                }
                
                
                self.medicineData.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, time: getTime))
            }
            
            self.medicineList.reloadData()
            
        }
        
    }

}
