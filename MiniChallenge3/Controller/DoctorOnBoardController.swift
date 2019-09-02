//
//  DoctorOnBoardController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit


class DoctorOnBoardController: UIViewController {
    

    @IBOutlet var onBoardDoctor: DoctorOnBoardView!
    
    var data : DoctorData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        closeKeyboardWhenClickView()
        
        navigationItem.title = "Data Psikiater"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4190294743, blue: 0.3407981396, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Selanjutnya", style: .plain, target: self, action: #selector(moveAction))
        
    }
    
    
    func getData() {
        
        guard let doctorName = onBoardDoctor.doctorNameInput.text else{
            return
        }
        guard let doctorNumber = onBoardDoctor.telephoneDoctor.text else {
            return
        }
        
        data = DoctorData(doctorName: doctorName, doctorNumber: doctorNumber)
//        data = DoctorData(doctorName: doctorName!, doctorHospital: doctorHospital!, verificationCode: verificationCode!)
        
    }
    

    @objc func moveAction(sender:UIButton){
        getData()
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
       
//        let vc = PatientOnBoardViewController()
//        vc.data = data
//        navigationController?.pushViewController(vc, animated: true)
         let page = storyboard.instantiateViewController(withIdentifier: "patientView") as! PatientOnBoardViewController
        page.data = data
        self.navigationController?.pushViewController(page, animated: true)
//        self.present(page, animated: true, completion: nil)
        
    }
    
    func closeKeyboardWhenClickView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
