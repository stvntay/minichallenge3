//
//  CreateRecordTableVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

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
    
    // TO DO:
    // - Fix the damn pickerview
    // - Integrate with CK
    
    let labelCellIdentifier = "TwoLabelsCell"
    let textFieldCellIdentifier = "TextfieldCell"
    let activityPickerCellIdentifier = "ActivityPickerCell"
    
    var valueToPass = -1
    var expandedRow = -1
    
    var activityValues = [
        activityValue(activityName: "Kencing", activityValue: "Mandiri"),
        activityValue(activityName: "Duduk", activityValue: "Bantuan")
    ]
    var medicineValues = [
        medicineValue(medicineName: "Cannabinol", medicineConsumptionFrequency: "99x"),
        medicineValue(medicineName: "Lysergic Acid Diethylamid", medicineConsumptionFrequency: "99x")
    ]
    var commentValues = [
        commentValue(commentTitle: "Bagaimana tidur pasien?", commentBody: "Nyenyak kayaknya"),
        commentValue(commentTitle: "Apakah ada keluhan / kejadian hari ini?", commentBody: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return medicineValues.count // replace with length of medicine list from CK
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
            cell.activityValue.text = activityValues[indexPath.row].activityValue
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }
        
        if indexPath.section == 1 {
            if indexPath.row != expandedRow {
                return 50
            }
        }
        
        // expanded & text field cell's height
        return 200
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            valueToPass = indexPath.row
            performSegue(withIdentifier: "segueToOptions", sender: self)
        }
        
        if indexPath.section == 1 {
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
        }
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? OptionsTableVC {
            medicineValues[sourceViewController.selectedRow].medicineConsumptionFrequency = sourceViewController.selectedValue
            print(sourceViewController.selectedValue)
            tableView.reloadData()
        }
    }
}
