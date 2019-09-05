//
//  CreateRecordViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 25/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class MedicineListViewController: UIViewController {
    
    
    @IBOutlet weak var medicineCategory: UISegmentedControl!
    @IBOutlet weak var medicineList: UITableView!
    var getCategory: String = ""
    var isFromAdd = Bool()
    
    var medicineDataRutin = [MedicineData]()
    var medicineDataSewaktu = [MedicineData]()
    
    var deletedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.medicineList.rowHeight = 210
//        if !isFromAdd {
//            getData()
//        } else {
//            medicineList.reloadData()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        medicineCategory.addTarget(self, action: #selector(chooseCategory), for: .valueChanged)
        
        medicineList.delegate = self
        medicineList.dataSource = self
        medicineList.register(UINib(nibName: "MedicineListTableViewCell", bundle: nil), forCellReuseIdentifier: "medicineList")
        
        navigationItem.title = "Obat"
//        let addImg = UIImage(named: "plusRiwayat")
//        let addButton = UIBarButtonItem(image: addImg, style: .plain, target: self, action: #selector(addMedicinePage))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMedicinePage))
        navigationItem.rightBarButtonItem = addButton
        
        clearNavigationBar()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        
        guard let category = medicineCategory.titleForSegment(at: medicineCategory.selectedSegmentIndex) else{
            return
        }
        getCategory = category
        if !isFromAdd {
            
            print("bukan dari add")
            getData()
        } else {
            isFromAdd = false
            print("dari add")
            medicineList.reloadData()
        }
    }
    
    @objc func chooseCategory(sender: UISegmentedControl){
        
        guard let category = medicineCategory.titleForSegment(at: medicineCategory.selectedSegmentIndex) else {
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
        let vc = storyboard.instantiateViewController(withIdentifier: "addMedicine") as? AddMedicineVC
        vc!.delegate = self
        vc?.medicineDataRutin = self.medicineDataRutin
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getData(){
        medicineDataRutin.removeAll()
        medicineDataSewaktu.removeAll()
        guard let userID = UserDefaults.standard.string(forKey: "userID") else{
            return
        }
        
//        let loadingView = Load.shared.showLoad()
//        self.present(loadingView, animated: true, completion: nil)
        MedicineModel.shared.loadMedicineData(userRN: userID) { (result) in
            for i in result {
                guard
                    let id = i.recordID.recordName as? String,
                    let getName =  i["namaObat"] as? String,
                    let getDesc = i["deskripsiObat"] as? String,
                    let getDose = i["dosisObat"]  as? String,
                    let getTime = i["setelahSebelumMakan"]  as? String,
                    let getCategory = i["kategori"] as? String,
                    let getFreq = i["jumlahPerHari"] as? String
                    else{
                        return
                }
                
                
                if getCategory == "Rutin" {
                    print("\(getCategory) = \(getName)")
                    self.medicineDataRutin.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: getFreq, time: getTime))
                }else if getCategory == "Sewaktu-waktu"{
                    print("\(getCategory) = \(getName)")
                    self.medicineDataSewaktu.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: getFreq, time: getTime))
                }
                
                DispatchQueue.main.async {
                    self.medicineList.reloadData()
                }
            }
//            loadingView.dismiss(animated: true, completion: nil)
//            loadingView.removeFromParent()
        }
    }
    
}

extension MedicineListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getCategory == "Rutin"{
            return medicineDataRutin.count
        }else{
            return medicineDataSewaktu.count
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
}

extension MedicineListViewController: AddMedicineVCDelegate {
    func refreshWithNewData(data: [MedicineData], category: String) {
        if data.last?.medicineCategory == "Rutin"{
            self.medicineDataRutin.append(data.last!)
        } else if data.last?.medicineCategory == "Sewaktu-waktu"{
            print("Sewaktu goblok")
            print(data.last?.medicineCategory)
            self.medicineDataSewaktu.append(data.last!)
        }
        self.getCategory = category
        self.isFromAdd = true
        medicineList.reloadData()
    }
}
