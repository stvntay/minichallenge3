//
//  AddMedicineVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 26/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class AddMedicineVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var patientDataSectionTitle: UILabel!
    
    @IBOutlet weak var medicineName: UITextField!
    @IBOutlet weak var medicineDosage: UITextField!
    @IBOutlet weak var medicineFrequency: UITextField!
    @IBOutlet weak var medicineBeforeAfterMealLabel: UITextField!
    
    @IBOutlet weak var medicineDataSectionTitle: UILabel!
    
    @IBOutlet weak var morningReminderLabel: UILabel!
    @IBOutlet weak var morningReminderHourPicker: UIPickerView!
    @IBOutlet weak var morningReminderMinutePicker: UIPickerView!
    
    @IBOutlet weak var afternoonReminderLabel: UILabel!
    @IBOutlet weak var afternoonReminderHourPicker: UIPickerView!
    @IBOutlet weak var afternoonReminderMinutePicker: UIPickerView!
    
    @IBOutlet weak var eveningReminderLabel: UILabel!
    @IBOutlet weak var eveningReminderHourPicker: UIPickerView!
    @IBOutlet weak var eveningReminderMinutePicker: UIPickerView!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    var hourOptions: [String] = []
    var minuteOptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for hour in 0...23 {
            hourOptions.append("\(hour)")
        }
        
        for minute in 0...59 {
            minuteOptions.append("\(minute)")
        }
        
        navBar.rightBarButtonItem = UIBarButtonItem(title: "Selesai", style: .done, target: self, action: #selector(onFinishTapped))
    }
    
    @objc func onFinishTapped() {
        let alertController = UIAlertController(title: "Verifikasi", message: "Masukkan kode verifikasi dari dokter", preferredStyle: .alert)
        let tombolPositif = UIAlertAction(title: "OK", style: .default) { (_) in
            self.performSegue(withIdentifier: "medicineList", sender: self)
        }
        let tombolNegatif = UIAlertAction(title: "Batalkan", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Kode Verifikasi"
        }
        alertController.addAction(tombolPositif)
        alertController.addAction(tombolNegatif)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag % 2) != 0 {
            return hourOptions.count
        }
        return minuteOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag % 2) != 0 {
            return "\(hourOptions[row])"
        }
        return "\(minuteOptions[row])"
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
    }
}
