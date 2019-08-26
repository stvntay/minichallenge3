//
//  DoctorOnBoardController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

struct DoctorData {
    var doctorName: String
    var doctorHospital: String
    var verificationCode: String
}

class DoctorOnBoardController: UIViewController {
    

    @IBOutlet var onBoardDoctor: DoctorOnBoardView!
    
    var data: DoctorData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func getData() {
        let doctorName = onBoardDoctor.doctorNameInput.text
        let doctorHospital = onBoardDoctor.hospitalNameInput.text
        let verificationCode = onBoardDoctor.verifCodeInput.text
        
        data = DoctorData(doctorName: doctorName!, doctorHospital: doctorHospital!, verificationCode: verificationCode!)
        moveToPatientPage()
    }
    
    func moveToPatientPage(){
        onBoardDoctor.nextPageBtn.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
    }

    @objc func moveAction(sender:UIButton){
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        let page = storyboard.instantiateViewController(withIdentifier: "patientView") as! PatientOnBoardViewController
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
