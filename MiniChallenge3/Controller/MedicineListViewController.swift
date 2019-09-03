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
    

    @IBOutlet weak var medicineCategory: UISegmentedControl!
    @IBOutlet weak var medicineList: UITableView!
    var getCategory: String = ""
    
    var medicineDataRutin : [MedicineData] = []
    var medicineDataSewaktu : [MedicineData] = []
    var arrayOfData = [CKRecord]()
    
    var deletedIndex: Int = 0
    var medicineRutin = 0
    var medicineSewaktu = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if getCategory == "Rutin"{
            return medicineRutin
        }else{
            return medicineSewaktu
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicineList", for: indexPath) as! MedicineListTableViewCell
        if getCategory == "Rutin" {
            //print(medicineData[indexPath.row].medicineCategory)
            cell.medicineName.text = medicineDataRutin[indexPath.row].medicineName
            cell.medicineTime.text = medicineDataRutin[indexPath.row].medicineTime
            cell.medicineDescription.text = medicineDataRutin[indexPath.row].medicineDesc
            cell.medicineFreq.text = "\(medicineDataRutin[indexPath.row].medicineFreq) x Sehari"
            cell.medicineAmount.text = medicineDataRutin[indexPath.row].medicineDose
        }else{
            cell.medicineName.text = medicineDataSewaktu[indexPath.row].medicineName
            cell.medicineTime.text = medicineDataSewaktu[indexPath.row].medicineTime
            cell.medicineFreq.text = "-"
            cell.medicineDescription.text = medicineDataSewaktu[indexPath.row].medicineDesc
            cell.medicineAmount.text = medicineDataSewaktu[indexPath.row].medicineDose
        }
        
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
        print("viewDidLoad")
        
        self.medicineList.rowHeight = 210
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        
        medicineList.isHidden = true
        
        medicineList.delegate = self
        medicineList.dataSource = self
        medicineList.register(UINib(nibName: "MedicineListTableViewCell", bundle: nil), forCellReuseIdentifier: "medicineList")
        
        getData()


        guard let category = medicineCategory.titleForSegment(at: medicineCategory.selectedSegmentIndex) else{
            return
        }

        getCategory = category
        print(getCategory)

        medicineCategory.addTarget(self, action: #selector(chooseCategory), for: .valueChanged)
        
        navigationItem.title = "Obat"
        let addImg = UIImage(named: "plusRiwayat")
        let addButton = UIBarButtonItem(image: addImg, style: .plain, target: self, action: #selector(addMedicinePage))
        
        navigationItem.rightBarButtonItem = addButton
        
        clearNavigationBar()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        
    }
    
    @objc func chooseCategory(sender: UISegmentedControl){
        
        guard let category = medicineCategory.titleForSegment(at: medicineCategory.selectedSegmentIndex) else{
            return
        }
        
        getCategory = category
        
        print("reload")
        medicineList.reloadData()
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
        let vc = storyboard.instantiateViewController(withIdentifier: "addMedicine") as! AddMedicineVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

//        let vc = AddMedicineVC()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData(){
        medicineDataRutin.removeAll()
        medicineDataSewaktu.removeAll()
        guard let userID = UserDefaults.standard.string(forKey: "userID") else{
            return
        }
        print(userID)

     
        MedicineModel.shared.loadMedicineData(userRN: userID) { (result) in
            
            for i in result {
                guard let id = i.recordID.recordName as? String else {
                    
                    return
                }
                guard let getName =  i["namaObat"] as? String else{
                    return
                }
                print(getName)
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
                
                guard let getFreq = i["jumlahPerHari"] as? String else{
                    return
                }
                if getCategory == "Rutin" {
                    self.medicineDataRutin.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: getFreq, time: getTime))
                    self.medicineRutin = self.medicineDataRutin.count
                }else{
                    self.medicineDataSewaktu.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: getFreq, time: getTime))
                    self.medicineSewaktu = self.medicineDataSewaktu.count
                }
                self.medicineList.isHidden = false
                self.medicineList.reloadData()
                self.medicineList.setNeedsLayout()
            }
        }
        
    }

}

extension MedicineListViewController: AddMedicineVCDelegate {
    func reloadDataBasedOnNewArray() {
        getData()
    }
}
