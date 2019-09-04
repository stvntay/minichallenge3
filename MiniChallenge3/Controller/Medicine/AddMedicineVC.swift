//
//  AddMedicineVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 26/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

protocol AddMedicineVCDelegate: class {
    func refreshWithNewData(data: [MedicineData], category: String)
}

class AddMedicineVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    
    @IBOutlet weak var addMedicineTitle: UILabel!
    @IBOutlet weak var medicineCategory: UITextField!
    @IBOutlet weak var medicineName: UITextField!
    @IBOutlet weak var medicineDescription: UITextField!
    @IBOutlet weak var medicineTime: UITextField!
    
    @IBOutlet weak var hari: UITextField!
    @IBOutlet weak var butir: UITextField!
    @IBOutlet weak var navBar: UINavigationItem!
    
    let medicineCategoryData: [String] = ["Rutin","Sewaktu-waktu"]
    let medicineTimeData: [String] = ["Sebelum makan","Sesudah makan"]
    let pickerCategory = UIPickerView()
    let pickerTime = UIPickerView()
    var categorySent = ""
    var getTime = ""
    var getCategory = ""
    var medicineDataRutin = [MedicineData]()
    var medicineDataSewaktu = [MedicineData]()
    
    weak var delegate: AddMedicineVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTextField()
        
        navigationItem.title = "Tambah Obat"
        
        
        closeKeyboardWhenClickView()
        medicineTime.delegate = self
        medicineCategory.delegate = self
        medicineTime.addTarget(self, action: #selector(chooseTime), for: .touchDown)
        medicineCategory.addTarget(self, action: #selector(chooseCategory), for: .touchDown)
        
        //let addImg = UIImage(named: "add-icon")
        let addButton = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(sendData))
        
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        navigationItem.rightBarButtonItem = addButton
        
        clearNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if categorySent == "Rutin"{
            self.delegate?.refreshWithNewData(data: self.medicineDataRutin, category: getCategory)
        }else if categorySent == "Sewaktu-waktu" {
            self.delegate?.refreshWithNewData(data: self.medicineDataSewaktu, category: getCategory)
        }
        
    }
    
    @objc func sendData(sender: UIBarButtonItem){
        guard let getName = medicineName.text else{
            return
        }
        
        guard let getDesc = medicineDescription.text else{
            return
        }
        
        guard let getDose = butir.text else{
            return
        }
        
        guard let getDay = hari.text else{
            return
        }
        
        guard let getUserID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        
        MedicineModel.shared.saveMedicineData(kategori: getCategory, namaObat: getName, deskripsiObat: getDesc, dosisObat: getDose, setelahSebelumMakan: getTime, jumlahPerHari: getDay, pasienRN: getUserID, completion: {
            (record) in
            
            print(record)
            
            guard
                let id = record.recordID.recordName as? String,
                let getName =  record["namaObat"] as? String,
                let getDesc = record["deskripsiObat"] as? String,
                let getDose = record["dosisObat"]  as? String,
                let getTime = record["setelahSebelumMakan"] as? String,
                let getCategory = record["kategori"] as? String,
                let getFreq = record["jumlahPerHari"] as? String
                else {
                    return
            }
            self.categorySent = getCategory
            if getCategory == "Rutin"{
                self.medicineDataRutin.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: getFreq, time: getTime))
            }else if getCategory == "Sewaktu-waktu"{
                print("add sewaktu")
                self.medicineDataSewaktu.append(MedicineData(ID: id, category: getCategory, name: getName, desc: getDesc, dose: getDose, freq: "-", time: getTime))
            }
            
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        
    }
    
    func editTextField(){
        medicineCategory.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineName.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineTime.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineDescription.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        
    }
    
    func clearNavigationBar(){
        func clearNavigationBar(){
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            navigationController?.view.backgroundColor = .clear
        }
    }
    
    
    func closeKeyboardWhenClickView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func chooseTime(sender: UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneChooseTime))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelChooseTime))
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        pickerTime.delegate = self
        medicineTime.inputAccessoryView = toolbar
        medicineTime.inputView = pickerTime
    }
    
    @objc func chooseCategory(sender: UITextField){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneChooseCategory))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelChooseCategory))
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        pickerCategory.delegate = self
        medicineCategory.inputAccessoryView = toolbar
        medicineCategory.inputView = pickerCategory
    }
    
    @objc func doneChooseTime(){
        medicineTime.text = getTime
        
        self.view.endEditing(true)
    }
    
    @objc func cancelChooseTime(){
        medicineCategory.text = ""
        
        self.view.endEditing(true)
    }
    
    @objc func doneChooseCategory(){
        medicineCategory.text = getCategory
        if getCategory == "Sewaktu-waktu"{
            hari.isEnabled = false
            hari.text = ""
        }else {
            hari.isEnabled = true
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelChooseCategory(){
        medicineCategory.text = ""
        if getCategory == "Sewaktu-waktu"{
            hari.isEnabled = false
            hari.text = ""
        }else {
            hari.isEnabled = true
        }
        self.view.endEditing(true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCategory {
            getCategory = medicineCategoryData[row]
            if getCategory == "Sewaktu-waktu"{
                hari.isEnabled = false
                hari.text = ""
            }else {
                hari.isEnabled = true
            }
            return getCategory
        }else if pickerView == pickerTime {
            getTime = medicineTimeData[row]
            return getTime
        }else{
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCategory {
            getCategory = medicineCategoryData[row]
            medicineCategory.text =  getCategory
            if getCategory == "Sewaktu-waktu"{
                hari.isEnabled = false
                hari.text = ""
            }else {
                hari.isEnabled = true
            }
        }else if pickerView == pickerTime {
            getTime = medicineTimeData[row]
            medicineTime.text = getTime
        }
    }
    
    
}

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UITextField {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}
