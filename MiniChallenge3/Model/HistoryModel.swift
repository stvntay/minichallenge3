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

final class HistoryModel {
    
    static var shared = HistoryModel()
    
    private init() {}
    
    // MARK: - Load history data to CloudKit
    
    func parseMedicineName(common: [CKRecord], rare: [CKRecord]) -> [String] {
        var dataNama = [String]()
        for data in common {
            dataNama.append(data["nama"] as! String)
        }
        for data in rare {
            dataNama.append(data["nama"] as! String)
        }
        return dataNama
        
    }
    
    func loadCommonMedicineData(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "CommonMedicineData", predicate: pred)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        query.sortDescriptors = [sort]
        
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
    
    func loadRareMedicineData(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "RareMedicineData", predicate: pred)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        query.sortDescriptors = [sort]
        
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
    
    func loadMedicalRecord(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "MedicalRecord", predicate: pred)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        query.sortDescriptors = [sort]
        
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
