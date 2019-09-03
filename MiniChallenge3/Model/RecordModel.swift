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

final class RecordModel {
    
    static var shared = RecordModel()
    
    private init() {}
    
    // MARK: - Load medicine name data from cloudkit
    
    func parseMedicineName(medicineDatas: [CKRecord]) -> [String] {
        var datas = [String]()
        
        for data in medicineDatas {
            datas.append(data["nama"] as! String)
        }
        return datas
    }
    
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
    
    // MARK: - Save record data to CloudKit
    
    func saveMedicalRecord(
            namaObat: [String],
            obat: [String],
            membersihkanDiri: String,
            makanDenganRapi: String,
            membersihkanPakaian: String,
            membersihkanRumah: String,
            berkomunikasiDenganLingkungan: String,
            tidurHariIni: String,
            catatan: String,
            pasienRN: String
        ) {
        let newData = CKRecord(recordType: "MedicalRecord")
        let pasienID = CKRecord.ID(recordName: pasienRN)
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        print(
          "Nama Obat:", namaObat,
          "Freq Obat:", obat,
          membersihkanDiri,
          makanDenganRapi,
          membersihkanPakaian,
          membersihkanRumah,
          berkomunikasiDenganLingkungan,
          "Tidur:", tidurHariIni,
          "Notes:", catatan
        )
        newData.setValue(namaObat, forKey: "namaObat")
        newData.setValue(obat, forKey: "obat")
        newData.setValue(membersihkanDiri, forKey: "membersihkanDiri")
        newData.setValue(makanDenganRapi, forKey: "makanDenganRapi")
        newData.setValue(membersihkanPakaian, forKey: "membersihkanPakaian")
        newData.setValue(membersihkanRumah, forKey: "membersihkanRumah")
        newData.setValue(berkomunikasiDenganLingkungan, forKey: "berkomunikasiDenganLingkungan")
        newData.setValue(tidurHariIni, forKey: "tidurHariIni")
        newData.setValue(catatan, forKey: "catatan")
        newData.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
}
