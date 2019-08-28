//
//  PatientOnBoardViewController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class PatientOnBoardViewController: UIViewController {
    
    
    @IBOutlet var patientView: PatientOnBoardView!
    var datepicker = UIDatePicker()
    var data : DoctorData?
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let getData = data else{
//            return
//        }
        
        // Do any additional setup after loading the view.
        initialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func initialization(){
        patientView.releaseDateInput.addTarget(self, action: #selector(getDateRelease), for: .touchDown)
    }
    
    @objc func getDateRelease(sender: UITextField){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datepicker.datePickerMode = .date
        patientView.releaseDateInput.inputAccessoryView = toolbar
        patientView.releaseDateInput.inputView = datepicker
//        datepicker.addTarget(self, action: #selector(DatePickerView), for: .touchUpInside)
    }
    
    @objc func doneDatePicker(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        patientView.releaseDateInput.text = dateFormatter.string(from: datepicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
