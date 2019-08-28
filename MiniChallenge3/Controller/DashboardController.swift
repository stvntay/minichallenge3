//
//  DashboardController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/22/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class DashboardController: UIViewController {
    
    var userID = CKRecord.ID()
    var doctorID = CKRecord.ID()
    var userDef = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID else {
                print(error.debugDescription)
                return
            }
            print(recordID)
            self.userID = recordID
        }
        
        doctorID = CloudData.shared.saveDoctorData(nama: "Finley", namaPuskesmas: "Ciledug", kodeVerifikasi: "1000")
        userDef.setValue(doctorID, forKey: "dokterID")
        
        userID = CloudData.shared.saveMedicalID(alamat: "Jl. A", nama: "Krisna", namaDokter: "Finley", statusPerawatan: "Sedang", tanggalLepasPasung: Date.distantPast, umur: 18, dokterID: doctorID)
        userDef.setValue(userID, forKey: "userID")
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
