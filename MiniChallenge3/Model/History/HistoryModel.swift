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
    
    func loadMedicineData(userRN: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let userID = CKRecord.ID(recordName: userRN)
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "MedicineData", predicate: pred)
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
    
    func loadMedicalRecord(userRN: String, dateClicked: String, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let userID = CKRecord.ID(recordName: userRN)
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let pred2 = NSPredicate(format: "date = %@", dateClicked)
        let searchCriteria = NSCompoundPredicate(andPredicateWithSubpredicates: [pred, pred2])
        let query = CKQuery(recordType: "MedicalRecord", predicate: searchCriteria)
        
        print("this func called load data")
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            DispatchQueue.main.async {
                if records != nil {
                    guard let records = records else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    print(records)
                    completion(records)
                } else {
                    print(error.debugDescription)
                }
            }
        }
        
    }
    
}
