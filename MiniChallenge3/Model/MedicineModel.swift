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
    
    func saveMedicineData(kategori: String, namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, jumlahPerHari: String, pasienRN: String) {
        let newData = CKRecord(recordType: "MedicineData")
        let pasienID = CKRecord.ID(recordName: pasienRN)
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(kategori, forKey: "kategori")
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
    
    // MARK: - Load medicine data to CloudKit
    
    func loadMedicineData(userRN: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let userID = CKRecord.ID(recordName: userRN)
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "MedicineData", predicate: pred)
        
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
    
    func updateMedicineData(records: [CKRecord], kategori: String, namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, jumlahPerHari: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        
        records[0].setValue(kategori, forKey: "kategori")
        records[0].setValue(namaObat, forKey: "namaObat")
        records[0].setValue(deskripsiObat, forKey: "deskripsiObat")
        records[0].setValue(dosisObat, forKey: "dosisObat")
        records[0].setValue(setelahSebelumMakan, forKey: "setelahSebelumMakan")
        records[0].setValue(jumlahPerHari, forKey: "jumlahPerHari")
        
        let modified = CKModifyRecordsOperation()
        modified.recordsToSave = records
        modified.savePolicy = .ifServerRecordUnchanged
        
        modified.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
            guard modified.isFinished == true else {
                print(error.debugDescription)
                return
            }
            if let savedRecords = savedRecords {
                print("update data success")
                completion(savedRecords)
            }
        }
        CKContainer.default().publicCloudDatabase.add(modified)
        
    }
    
}
