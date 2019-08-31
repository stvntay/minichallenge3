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

final class ProfileModel {
    
    static var shared = ProfileModel()
    
    private init() {}
    
    // MARK: - Load profile data to CloudKit
    
    func loadPsikiaterData(doctorID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "recordID = %@", doctorID)
        let query = CKQuery(recordType: "PsikiaterData", predicate: pred)
        
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
    
    func loadMedicalID(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "recordID = %@", userID)
        let query = CKQuery(recordType: "MedicalID", predicate: pred)
        
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
