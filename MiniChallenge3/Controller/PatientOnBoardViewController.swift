//
//  PatientOnBoardViewController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class PatientOnBoardViewController: UIViewController {
    
    
    @IBOutlet var patientView: PatientOnBoardView!
    var datepicker = UIDatePicker()
    var data : DoctorData?
    var onBoardData: OnBoardData?
//    var cloudData = CloudData()
    var doctorID: String = ""
    var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let getData = data else{
//            return
//        }
        
        // Do any additional setup after loading the view.
        initialization()
        closeKeyboardWhenClickView()
        
        navigationItem.title = "Data Pasien"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4190294743, blue: 0.3407981396, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Selesai", style: .plain, target: self, action: #selector(submitData))
        
    }
    
    func closeKeyboardWhenClickView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       //initialization()
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
        dateFormatter.dateFormat = "dd/MM/yyyy"
        patientView.releaseDateInput.text = dateFormatter.string(from: datepicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func submitData(sender: UIButton){
        
       
        guard let getData = data else{
            return
        }
        
        guard let patientName = patientView.namePatientInput.text else{
            return
        }
        guard let patientAge = patientView.agePatientInput.text else{
            return
        }
        guard let releaseDate = patientView.releaseDateInput.text else{
            return
        }
        guard let patientAddress = patientView.addressPatientInput.text else{
            return
        }
        guard let patientHospital = patientView.hospitalInput.text else{
            return
        }
        
//        onBoardData = OnBoardData(doctorData: getData, name: patientName, age: patientAge, date: releaseDate, address: patientAddress, hospital: patientHospital)
//
   
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let date = dateFormatter.date(from: releaseDate)
        
     
        guard let convertPatientAge = Int(patientAge) else { return  }
        
        let storyboard = UIStoryboard(name: "TabMenu", bundle: nil)
        
        //        let vc = PatientOnBoardViewController()
        //        vc.data = data
        //        navigationController?.pushViewController(vc, animated: true)
        let page = storyboard.instantiateViewController(withIdentifier: "menuTab") as! UITabBarController
        
        self.present(page, animated: true, completion: nil)

        
//        OnboardModel.shared.savePsikiaterAndUserData(namaPsikiater: getData.doctorName, nomorTelepon: getData.doctorNumber, alamat: patientAddress, namaUser: patientName, tanggalLepasPasung: date!, umur: convertPatientAge, puskesmas: patientHospital, completion: { (passDoctorID, passUserID) in
//            
//            
//            self.doctorID = passDoctorID
//            self.userID = passUserID
//
////            let userIDString = self.userID
//            UserDefaults.standard.set(self.userID,forKey: "userID")
//            
//            
////            let storyboard = UIStoryboard(name: "TabMenu", bundle: nil)
////
////            //        let vc = PatientOnBoardViewController()
////            //        vc.data = data
////            //        navigationController?.pushViewController(vc, animated: true)
////            let page = storyboard.instantiateViewController(withIdentifier: "menuTab") as! UITabBarController
////           
////            self.present(page, animated: true, completion: nil)
//            
////            guard let idDoctor = self.doctorID else{
////                return
////            }
////            guard let idUser = self.userID else{
////                return
////            }
//            
//            })
        
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
