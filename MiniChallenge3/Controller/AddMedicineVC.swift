//
//  AddMedicineVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 26/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class AddMedicineVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    

    @IBOutlet weak var addMedicineTitle: UILabel!
    @IBOutlet weak var medicineCategory: UITextField!
    @IBOutlet weak var medicineName: UITextField!
    @IBOutlet weak var medicineDescription: UITextField!
    @IBOutlet weak var medicineDosage: UITextField!
    @IBOutlet weak var medicineTime: UITextField!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    let medicineCategoryData: [String] = ["Rutin","Sewaktu-waktu"]
    let medicineTimeData: [String] = ["Sebelum makan","Sesudah makan"]
    let pickerCategory = UIPickerView()
    let pickerTime = UIPickerView()
    var getCategory = ""
    var getTime = ""
    
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
    
    @objc func sendData(sender: UIBarButtonItem){
        guard let getName = medicineName.text else{
            return
        }
        
        guard let getDesc = medicineDescription.text else{
            return
        }
        
        guard let getDose = medicineDosage.text else{
            return
        }
        
        guard let getUserID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        
        if getCategory == "Rutin" {
           MedicineModel.shared.saveMedicineData(kategori: getCategory, namaObat: getName, deskripsiObat: getDesc, dosisObat: getDose, setelahSebelumMakan: getTime, jumlahPerHari: 3, pasienRN: getUserID)
        }else if getCategory == "Sewaktu-waktu"{
            MedicineModel.shared.saveMedicineData(kategori: getCategory, namaObat: getName, deskripsiObat: getDesc, dosisObat: getDose, setelahSebelumMakan: getTime, jumlahPerHari: 0, pasienRN: getUserID)
        }
        
        
        
        let storyboard = UIStoryboard(name: "TabMenu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "menuTab") as! UITabBarController
        self.present(vc, animated: true,completion: nil)
        
    }
    
    func editTextField(){
        medicineCategory.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineName.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineTime.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineDescription.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineDosage.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
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
        self.view.endEditing(true)
    }
    
    @objc func cancelChooseCategory(){
        medicineCategory.text = ""
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

