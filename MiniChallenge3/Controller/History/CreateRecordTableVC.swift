//
//  CreateRecordTableVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

let sectionTitle = ["Obat", "Aktivitas", "Tidur", "Keluhan"]
var rowsPerSection = [0, 0, 1, 1]

struct medicineValue {
    var medicineName: String
    var medicineConsumptionFrequency: String
}

struct activityValue {
    var activityName: String
    var activityValue: String
}

struct commentValue {
    var commentTitle: String
    var commentBody: String
}

class CreateRecordTableVC: UITableViewController {
    
    let labelCellIdentifier = "TwoLabelsCell"
    let textFieldCellIdentifier = "TextfieldCell"
    let activityPickerCellIdentifier = "ActivityPickerCell"

    var valueToPass = -1
    var expandedRow = -1
    
    var medicineValues = [medicineValue]()
    var activityValues = [
        activityValue(activityName: "Membersihkan diri", activityValue: ""),
        activityValue(activityName: "Makan dengan rapi", activityValue: ""),
        activityValue(activityName: "Membereskan pakaian", activityValue: ""),
        activityValue(activityName: "Membersihkan rumah", activityValue: ""),
        activityValue(activityName: "Komunikasi dengan baik", activityValue: ""),
    ]
    var commentValues = [
        commentValue(commentTitle: "Bagaimana tidur pasien?", commentBody: ""),
        commentValue(commentTitle: "Apakah ada keluhan / kejadian hari ini?", commentBody: "")
    ]
    
    var medicineFreq = [String]()
    
    var membersihkanDiri = ""
    var makanDenganRapi = ""
    var membersihkanPakaian = ""
    var membersihkanRumah = ""
    var berkomunikasiDenganLingkungan = ""
    
    var CKMedicineData = [CKRecord]()
    var medicineNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.title = "Buat Catatan"
        
        RecordModel.shared.loadMedicineData(userRN: "5187BE88-B4D8-4E65-B2D4-6D20663B6D6C") { (result) in
            self.CKMedicineData = result
        }
        
        // populate local variable with medicine data
        // medicine name
        medicineNames = RecordModel.shared.parseMedicineName(medicineDatas: CKMedicineData)
        
        // medicine frequency
        for name in medicineNames {
            medicineValues.append(medicineValue(medicineName: name, medicineConsumptionFrequency: "Pilih"))
        }
        
        let addButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(submit))
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        navigationItem.rightBarButtonItem = addButton
        
        tableView.register(
            UINib(nibName: "TwoLabelsCell", bundle: nil),
            forCellReuseIdentifier: labelCellIdentifier
        )
        tableView.register(
            UINib(nibName: "TextFieldCell", bundle: nil),
            forCellReuseIdentifier: textFieldCellIdentifier
        )
        tableView.register(
            UINib(nibName: "ActivityPickerCell", bundle: nil),
            forCellReuseIdentifier: activityPickerCellIdentifier
        )
        tableView.register(
            ActivityRecordHeader.self,
            forHeaderFooterViewReuseIdentifier: "sectionHeader"
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return medicineValues.count
        }
        
        if section == 1 {
            return activityValues.count
        }
        
        return rowsPerSection[section]
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt
        indexPath: IndexPath
    ) -> UITableViewCell {
        
        // Medicine Section
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: labelCellIdentifier,
                for: indexPath
                ) as! TwoLabelsCell
            cell.title.text = medicineValues[indexPath.row].medicineName
            cell.cellValue.text = medicineValues[indexPath.row].medicineConsumptionFrequency
            return cell
        }
        
        // Activity Section
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: activityPickerCellIdentifier,
                for: indexPath
                ) as! ActivityPickerCell
            cell.activityName.text = activityValues[indexPath.row].activityName
            cell.activityValue.text = "Pilih"
            
            cell.activityPicker.isHidden = true
            return cell
        }
        
        // Sleep section
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: textFieldCellIdentifier,
                for: indexPath
                ) as! TextFieldCell
            
            cell.question.text = commentValues[0].commentTitle
            cell.textInput.text = commentValues[0].commentBody
            
            return cell
        }
        
        // Keluhan section
        let cell = tableView.dequeueReusableCell(
            withIdentifier: textFieldCellIdentifier,
            for: indexPath
            ) as! TextFieldCell
        
        cell.question.text = commentValues[1].commentTitle
        cell.textInput.text = commentValues[1].commentBody
        
        return cell
    }
    
    @objc func goToActivityGuide() {
        performSegue(withIdentifier: "toActivityGuide", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }
        
        if indexPath.section == 1 {
            if indexPath.row != expandedRow {
                return 50
            }
            return 200
        }
        
        // text field cell's height
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            valueToPass = indexPath.row
            performSegue(withIdentifier: "segueToOptions", sender: self)
        }
        
        if indexPath.section == 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? ActivityPickerCell else {return}
            if expandedRow == indexPath.row {
                cell.activityPicker.isHidden = true
                expandedRow = -1
            } else {
                expandedRow = indexPath.row
                cell.activityPicker.isHidden = false
            }
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as! ActivityRecordHeader
        
        if section == 1 {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToActivityGuide))
            view.image.image = UIImage(named: "info-icon")
            view.image.layer.cornerRadius = 11
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToOptions" {
            let destination = segue.destination as! OptionsTableVC
            destination.selectedRow = valueToPass
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? OptionsTableVC {
            medicineValues[sourceViewController.selectedRow].medicineConsumptionFrequency = sourceViewController.selectedValue
            tableView.reloadData()
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        if medicineValues.count > 0 {
            for x in 0...medicineValues.count - 1 {
                medicineNames.append(medicineValues[x].medicineName)
                medicineFreq.append(medicineValues[x].medicineConsumptionFrequency)
            }
        }
        
        for x in 0...activityValues.count - 1 {
            let indexes = IndexPath.init(row: x, section: 1)
            let cell = tableView.cellForRow(at: indexes) as! ActivityPickerCell
            
            if x == 0 {
                membersihkanDiri = cell.activityValue.text ?? "Belum dipilih"
            } else if x == 1 {
                makanDenganRapi = cell.activityValue.text ?? "Belum dipilih"
            } else if x == 2 {
                membersihkanPakaian = cell.activityValue.text ?? "Belum dipilih"
            } else if x == 3 {
                membersihkanRumah = cell.activityValue.text ?? "Belum dipilih"
            } else {
                berkomunikasiDenganLingkungan = cell.activityValue.text ?? "Belum dipilih"
            }
        }
        
        for x in 2...3 {
            let indexes = IndexPath.init(row: 0, section: x)
            let cell = tableView.cellForRow(at: indexes) as! TextFieldCell
            if x == 2 {
                commentValues[0].commentBody = cell.textInput.text
            } else {
                commentValues[1].commentBody = cell.textInput.text
            }
        }
        
        RecordModel.shared.saveMedicalRecord(
            namaObat: medicineNames,
            obat: medicineFreq,
            membersihkanDiri: membersihkanDiri,
            makanDenganRapi: makanDenganRapi,
            membersihkanPakaian: membersihkanPakaian,
            membersihkanRumah: membersihkanPakaian,
            berkomunikasiDenganLingkungan: berkomunikasiDenganLingkungan,
            tidurHariIni: commentValues[0].commentBody,
            catatan: commentValues[1].commentBody,
            pasienRN: UserDefaults.standard.string(forKey: "userID") ?? "", completion:{ (rec) in
                
        })
        navigationController?.popToRootViewController(animated: true)
    }
}
