//
//  CloudData.swift
//  MiniChallenge3
//
//  Created by I Putu Krisna on 23/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

final class OnboardModel {
    
    static var shared = OnboardModel()
    
    private init() {}
    
    // MARK: - Save onboard data to CloudKit
    
    func savePsikiaterAndUserData(namaPsikiater: String, nomorTelepon: String, alamat: String, namaUser: String, tanggalLepasPasung: Date, umur: Int, puskesmas: String, completion: @escaping (_ doctorRecordName: String, _ userRecordName: String) -> Void) {
        let doctorData = CKRecord(recordType: "PsikiaterData")
        let userData = CKRecord(recordType: "MedicalID")
        var recordDoctorID = CKRecord.ID()
        var recordUserID = CKRecord.ID()
        
        doctorData.setValue(namaPsikiater, forKey: "nama")
        doctorData.setValue(nomorTelepon, forKey: "nomorTelepon")
        
        CKContainer.default().publicCloudDatabase.save(doctorData) { (recordDoctor, error) in
            if recordDoctor != nil {
                DispatchQueue.main.async {
                    recordDoctorID = recordDoctor!.recordID
                    //                    print(recordDoctorID)
                    let reference = CKRecord.Reference(recordID: recordDoctorID, action: .deleteSelf)
                    
                    userData.setValue(alamat, forKey: "alamat")
                    userData.setValue(namaUser, forKey: "nama")
                    userData.setValue(reference, forKey: "dokterID")
                    userData.setValue(tanggalLepasPasung, forKey: "tanggalLepasPasung")
                    userData.setValue(umur, forKey: "umur")
                    userData.setValue(puskesmas, forKey: "puskesmas")
                    
                    CKContainer.default().publicCloudDatabase.save(userData) { (recordUser, error) in
                        if recordUser != nil {
                            DispatchQueue.main.async {
                                recordUserID = recordUser!.recordID
                                completion(recordDoctorID.recordName, recordUserID.recordName)
                            }
                        } else {
                            print(error.debugDescription)
                        }
                    }
                }
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
}
