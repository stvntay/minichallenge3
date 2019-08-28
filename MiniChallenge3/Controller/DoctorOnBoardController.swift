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
        
        
        
        moveToPatientPage()
        // Do any additional setup after loading the view.
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
    
    func moveToPatientPage(){
        
        onBoardDoctor.nextPageBtn.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
    }

    @objc func moveAction(sender:UIButton){
        getData()
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
//        let vc = PatientOnBoardViewController()
//        vc.data = data
//        navigationController?.pushViewController(vc, animated: true)
         let page = storyboard.instantiateViewController(withIdentifier: "patientView") as! PatientOnBoardViewController
        page.data = data
        self.present(page, animated: true, completion: nil)
        
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
