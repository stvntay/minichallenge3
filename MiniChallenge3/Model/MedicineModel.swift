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

final class MedicineModel {
    
    static var shared = MedicineModel()
    
    private init() {}
    
    // MARK: - Save medicine data to CloudKit
    
    func saveCommonMedicineData(namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, jumlahPerHari: Int, pasienRN: String) {
        let newData = CKRecord(recordType: "CommonMedicineData")
        let pasienID = CKRecord.ID(recordName: pasienRN)
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(namaObat, forKey: "namaObat")
        newData.setValue(deskripsiObat, forKey: "deskripsiObat")
        newData.setValue(dosisObat, forKey: "dosisObat")
        newData.setValue(setelahSebelumMakan, forKey: "setelahSebelumMakan")
        newData.setValue(jumlahPerHari, forKey: "jumlahPerHari")
        newData.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    func saveRareMedichineData(namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, pasienRN: String) {
        let newData = CKRecord(recordType: "RareMedicineData")
        let pasienID = CKRecord.ID(recordName: pasienRN)
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(namaObat, forKey: "namaObat")
        newData.setValue(deskripsiObat, forKey: "deskripsiObat")
        newData.setValue(dosisObat, forKey: "dosisObat")
        newData.setValue(setelahSebelumMakan, forKey: "setelahSebelumMakan")
        newData.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    // MARK: - Load medicine data to CloudKit
    
    func loadCommonMedicineData(userRN: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let userID = CKRecord.ID(recordName: userRN)
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "CommonMedicineData", predicate: pred)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            DispatchQueue.main.async {
                guard let records = records else {
                    print(error?.localizedDescription as Any)
                    return
                }
                print(records)
                completion(records)
            }
        }
        
    }
    
    func loadRareMedicineData(userRN: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let userID = CKRecord.ID(recordName: userRN)
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "RareMedicineData", predicate: pred)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            DispatchQueue.main.async {
                guard let records = records else {
                    print(error?.localizedDescription as Any)
                    return
                }
                print(records)
                completion(records)
            }
        }
        
    }
    
}
