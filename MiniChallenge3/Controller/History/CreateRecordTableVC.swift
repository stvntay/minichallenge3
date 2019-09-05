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
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    var valueToPass = -1
    var expandedRow = -1
    
    var medicineValues = [medicineValue]()
    var activityValues = [
        activityValue(activityName: "Membersihkan diri", activityValue: "Pilih"),
        activityValue(activityName: "Makan dengan rapi", activityValue: "Pilih"),
        activityValue(activityName: "Membereskan pakaian", activityValue: "Pilih"),
        activityValue(activityName: "Membersihkan rumah", activityValue: "Pilih"),
        activityValue(activityName: "Komunikasi dengan baik", activityValue: "Pilih"),
    ]
    var commentValues = [
        commentValue(commentTitle: "Bagaimana tidur pasien?", commentBody: ""),
        commentValue(commentTitle: "Apakah ada keluhan / kejadian hari ini?", commentBody: "")
    ]
    
    var medicineFreq = [String]()
    var medicineNames = [String]()

    let activityOptions = ["Mandiri", "Bantuan", "Tergantung"]
    var selectedActivity = Int()
    var membersihkanDiri = ""
    var makanDenganRapi = ""
    var membersihkanPakaian = ""
    var membersihkanRumah = ""
    var berkomunikasiDenganLingkungan = ""
    
    let getUserID = UserDefaults.standard.string(forKey: "userID") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - VDL Setup picker
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 500, width: UIScreen.main.bounds.size.width, height: 400)
        
        // MARK - VDL Setup picker's toolbar
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 500, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped)),
            UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(onCancelButtonTapped))
        ]
        
        // MARK - VDL Load medicine list
        RecordModel.shared.loadMedicineData(userRN: getUserID) { (result) in
            if result.count > 0 {
                self.medicineNames = RecordModel.shared.parseMedicineName(medicineData: result)
                for name in self.medicineNames {
                    self.medicineValues.append(medicineValue(medicineName: name, medicineConsumptionFrequency: "Pilih"))
                }
                self.tableView.reloadData()
            }
        }
        
        // MARK - VDL Setup navbar
        let addButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(submit))
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        navigationItem.rightBarButtonItem = addButton
        
        // MARK - VDL Register custom nibs
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        // Activity Section
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: activityPickerCellIdentifier,
                for: indexPath
                ) as! ActivityPickerCell
            let gestureRecognizer = desperatelyCustomGestureRecognizer(target: self, action: #selector(onActivityTapped))
            gestureRecognizer.selectedRow = indexPath.row
            cell.addGestureRecognizer(gestureRecognizer)
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
            cell.textInput.delegate = self
            cell.textInput.tag = 0
            cell.question.text = commentValues[0].commentTitle
            cell.textInput.text = commentValues[0].commentBody
            
            return cell
        }
        
        // Keluhan section
        let cell = tableView.dequeueReusableCell(
            withIdentifier: textFieldCellIdentifier,
            for: indexPath
            ) as! TextFieldCell
        
        cell.textInput.delegate = self
        cell.textInput.tag = 1
        cell.question.text = commentValues[1].commentTitle
        cell.textInput.text = commentValues[1].commentBody
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 ||
            indexPath.section == 1 {
            return 50
        }
        // text field cell's height
        return 200
    }
    
    
    @objc func goToActivityGuide() {
        performSegue(withIdentifier: "toActivityGuide", sender: self)
    }
    
    // Picker's interaction
    @IBAction func onActivityTapped(_ sender: desperatelyCustomGestureRecognizer) {
        selectedActivity = sender.selectedRow
        self.view.addSubview(picker)
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    @objc func onCancelButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            valueToPass = indexPath.row
            performSegue(withIdentifier: "segueToOptions", sender: self)
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
        print("Tombol selesai ditekan")
        for x in 0...medicineValues.count - 1 {
            medicineFreq.append(medicineValues[x].medicineConsumptionFrequency)
        }
        
        RecordModel.shared.saveMedicalRecord(
            namaObat: medicineNames,
            obat: medicineFreq,
            membersihkanDiri: activityValues[0].activityValue,
            makanDenganRapi: activityValues[1].activityValue,
            membersihkanPakaian: activityValues[2].activityValue,
            membersihkanRumah: activityValues[3].activityValue,
            berkomunikasiDenganLingkungan: activityValues[4].activityValue,
            tidurHariIni: commentValues[0].commentBody,
            catatan: commentValues[1].commentBody,
            pasienRN: getUserID, completion:{ (rec) in
                
        })
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CreateRecordTableVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activityValues[selectedActivity].activityValue = activityOptions[row]
        tableView.reloadData()
    }
}

extension CreateRecordTableVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        commentValues[textView.tag].commentBody = textView.text
    }
}

class desperatelyCustomGestureRecognizer: UITapGestureRecognizer {
    var selectedRow = Int()
}
