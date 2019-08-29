//
//  DashboardData.swift
//  MiniChallenge3
//
//  Created by I Putu Krisna on 23/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

final class DashboardData {
    
    static var shared = DashboardData()
    
    private init() {}
    
    func saveInformasiObat(suggestion: String) {
        var userID = CKRecord.ID()
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID else {
                print(error.debugDescription)
                return
            }
            userID = recordID
        }
        
        let newRecord = CKRecord(recordType: "MedicineInformation")
        let reference = CKRecord.Reference(recordID: userID, action: .deleteSelf)
        
        newRecord["NamaObat"] = "Aripiprazole (Abilify)" as CKRecordValue
        newRecord["FungsiObat"] = "Digunakan untuk meredakan episode mania dan gangguan suasana hati" as CKRecordValue
        newRecord["DosisObat"] = ["Dewasa 15 mg - 30 mg per hari", "Remaja 1 mg - 2.5 mg per hari"] as CKRecordValue
        newRecord["WaktuKonsumsi"] = "Dikonsumsi sebelum atau setelah makan" as CKRecordValue
        newRecord["Pasien_ID"] = reference as CKRecordValue
        newRecord.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newRecord) { (records, error) in
            guard records != nil else {
                print(error.debugDescription)
                return
            }
            print("save data success")
        }
        
    }
    
    //load 

    func loadInformasiObat () -> [CKRecord] {
        var data = [CKRecord]()
        var userID = CKRecord.ID()
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let recordID = recordID else {
                print(error.debugDescription)
                return
            }
            userID = recordID
        }
        
        let reference = CKRecord.Reference(recordID: userID, action: .deleteSelf)
        let pred = NSPredicate(format: "owningWhistle == %@", reference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "MedicineInformation", predicate: pred)
        query.sortDescriptors = [sort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print(error?.localizedDescription as Any)
                return
            }
            let sortRecords = records.sorted(by: { $0.creationDate! < $1.creationDate!
            })
            data = sortRecords
            
        }
        
        return data
        
    }
    
}
