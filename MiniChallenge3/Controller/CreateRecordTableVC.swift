//
//  CreateRecordTableVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

let sectionTitle = ["Obat Rutin", "Obat Non-rutin", "Aktivitas", "Tidur", "Keluhan"]
var rowsPerSection = [0, 0, 0, 1, 1]

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
    
    // TO DO:
    // - Fix the damn pickerview, it's fuckin cliping through the cells!!!!
    // - Integrate with CK
    
    let labelCellIdentifier = "TwoLabelsCell"
    let textFieldCellIdentifier = "TextfieldCell"
    let activityPickerCellIdentifier = "ActivityPickerCell"

    var valueToPass = -1
    var expandedRow = -1
    var medicineType = -1
    
    var activityValues = [
        activityValue(activityName: "Membersihkan diri", activityValue: "Belum Diatur"),
        activityValue(activityName: "Makan dengan rapi", activityValue: "Belum Diatur"),
        activityValue(activityName: "Membereskan pakaian", activityValue: "Belum Diatur"),
        activityValue(activityName: "Membersihkan rumah", activityValue: "Belum Diatur"),
        activityValue(activityName: "Komunikasi dengan baik", activityValue: "Belum Diatur"),
    ]
    var routineMedicineValues = [medicineValue]()
    var occasionalMedicineValues = [medicineValue]()
    
//    var medicineValues = [
//        medicineValue(medicineName: "Cannabinol", medicineConsumptionFrequency: "99x"),
//        medicineValue(medicineName: "Lysergic Acid Diethylamid", medicineConsumptionFrequency: "99x")
//    ]
    
    var commentValues = [
        commentValue(commentTitle: "Bagaimana tidur pasien?", commentBody: "Nyenyak kayaknya"),
        commentValue(commentTitle: "Apakah ada keluhan / kejadian hari ini?", commentBody: "")
    ]
    
    var routineMedicineFreq = [String]()
    var occasionalMedicineFreq = [String]()
    
    var membersihkanDiri = ""
    var makanDenganRapi = ""
    var membersihkanPakaian = ""
    var membersihkanRumah = ""
    var berkomunikasiDenganLingkungan = ""
    
    var CKCommonMedicineData = [CKRecord]()
    var CKRareMedicineData = [CKRecord]()
    var routineMedicineNames = [String]()
    var occasionalMedicineNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RecordModel.shared.loadCommonMedicineData(userRN: "5187BE88-B4D8-4E65-B2D4-6D20663B6D6C") { (result) in
            self.CKCommonMedicineData = result
        }
        
        RecordModel.shared.loadRareMedicineData(userRN: "5187BE88-B4D8-4E65-B2D4-6D20663B6D6C") { (result) in
            self.CKRareMedicineData = result
        }
        
        routineMedicineNames = RecordModel.shared.parseMedicineName(medicineDatas: CKCommonMedicineData)
        
        occasionalMedicineNames = RecordModel.shared.parseMedicineName(medicineDatas: CKRareMedicineData)
        
        for name in routineMedicineNames {
            routineMedicineValues.append(medicineValue(medicineName: name, medicineConsumptionFrequency: "Pilih"))
        }
        
        for name in occasionalMedicineNames {
            occasionalMedicineValues.append(medicineValue(medicineName: name, medicineConsumptionFrequency: "1x"))
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
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return routineMedicineNames.count
        }
        
        if section == 1 {
            return occasionalMedicineNames.count
        }
        
        if section == 2 {
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
            cell.title.text = routineMedicineNames[indexPath.row]
//            cell.cellValue.text = medicineValues[indexPath.row].medicineConsumptionFrequency
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: labelCellIdentifier,
                for: indexPath
                ) as! TwoLabelsCell
            cell.title.text = occasionalMedicineNames[indexPath.row]
//            cell.cellValue.text = medicineValues[indexPath.row].medicineConsumptionFrequency
            return cell
        }
        
        // Activity Section
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: activityPickerCellIdentifier,
                for: indexPath
                ) as! ActivityPickerCell
            cell.activityName.text = activityValues[indexPath.row].activityName
            cell.activityValue.text = "Pilih"
            return cell
        }
        
        // Sleep section
        if indexPath.section == 3 {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 ||
            indexPath.section == 1
        {
            return 50
        }
        
        if indexPath.section == 2 {
            if indexPath.row != expandedRow {
                return 50
            }
            return 120
        }
        
        // text field cell's height
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 ||
            indexPath.section == 1
        {
            valueToPass = indexPath.row
            medicineType = indexPath.section
            performSegue(withIdentifier: "segueToOptions", sender: self)
        }
        
        if indexPath.section == 2 {
            if expandedRow == indexPath.row {
                expandedRow = -1
            } else {
                expandedRow = indexPath.row
            }
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToOptions" {
            let destination = segue.destination as! OptionsTableVC
            destination.selectedRow = valueToPass
            destination.selectedMedicineType = medicineType
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? OptionsTableVC {
            if sourceViewController.selectedMedicineType == 1 { occasionalMedicineValues[sourceViewController.selectedRow].medicineConsumptionFrequency = sourceViewController.selectedValue
            } else if sourceViewController.selectedMedicineType == 0 {
                routineMedicineValues[sourceViewController.selectedRow].medicineConsumptionFrequency = sourceViewController.selectedValue
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        for routineMedicine in routineMedicineValues {
            routineMedicineFreq.append(routineMedicine.medicineConsumptionFrequency)
        }
        
        for occasionalMedicine in occasionalMedicineValues {
            occasionalMedicineFreq.append(occasionalMedicine.medicineConsumptionFrequency)
        }
        
        for x in 0...activityValues.count - 1 {
            let indexes = IndexPath.init(row: x, section: 2)
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
        
        for x in 3...4 {
            let indexes = IndexPath.init(row: 0, section: x)
            let cell = tableView.cellForRow(at: indexes) as! TextFieldCell
            if x == 3 {
                commentValues[0].commentBody = cell.textInput.text
            } else {
                commentValues[1].commentBody = cell.textInput.text
            }
        }
        
        RecordModel.shared.saveMedicalRecord(
            obatRutin: routineMedicineFreq,
            obatSewaktu: occasionalMedicineFreq,
            membersihkanDiri: membersihkanDiri,
            makanDenganRapi: makanDenganRapi,
            membersihkanPakaian: membersihkanPakaian,
            membersihkanRumah: membersihkanPakaian,
            berkomunikasiDenganLingkungan: berkomunikasiDenganLingkungan,
            tidurHariIni: commentValues[0].commentBody,
            catatan: commentValues[1].commentBody,
            pasienRN: "String STOP DISINI"
        )
    }
}
