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

final class CloudData {
    
    static var shared = CloudData()
    
    private init() {}
    
    // MARK: - Save data to CloudKit
    
    func saveDoctorData(nama: String, nomorTelepon: String, completion: @escaping (_ recID: CKRecord.ID) -> Void) {
        let newData = CKRecord(recordType: "DoctorData")
        var recordID = CKRecord.ID()
        
        newData.setValue(nama, forKey: "nama")
        newData.setValue(nomorTelepon, forKey: "nomorTelepon")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                DispatchQueue.main.async {
                    recordID = record!.recordID
                    print(recordID)
                    completion(recordID)
                }
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    func saveMedicalID(alamat: String, nama: String, tanggalLepasPasung: Date, umur: Int, dokterID: CKRecord.ID, puskesmas: String, completion: @escaping (_ recID: CKRecord.ID) -> Void) {
        
        let newData = CKRecord(recordType: "MedicalID")
        var recordID = CKRecord.ID()
        let reference = CKRecord.Reference(recordID: dokterID, action: .deleteSelf)
        
        newData.setValue(alamat, forKey: "alamat")
        newData.setValue(nama, forKey: "nama")
        newData.setValue(reference, forKey: "dokterID")
        newData.setValue(tanggalLepasPasung, forKey: "tanggalLepasPasung")
        newData.setValue(umur, forKey: "umur")
        newData.setValue(puskesmas, forKey: "puskesmas")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                DispatchQueue.main.async {
                    recordID = record!.recordID
                    completion(recordID)
                }
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    func saveCommonMedicineData(namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, jumlahPerHari: Int, pasienID: CKRecord.ID) {
        let newData = CKRecord(recordType: "CommonMedicineData")
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
    
    func saveRareMedicalData(namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, pasienID: CKRecord.ID) {
        let newData = CKRecord(recordType: "RareMedicineData")
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
    
    //function yang ini belum di update datanya, belum bisa dipake
    func saveMedicineRecord(namaObat: String, tanggalWaktu: Date, pasienID: CKRecord.ID) {
        let newData = CKRecord(recordType: "MedicineRecord")
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(namaObat, forKey: "namaObat")
        newData.setValue(tanggalWaktu, forKey: "tanggalWaktu")
        newData.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    //function yang ini belum di update datanya, belum bisa dipake
    func savePatientRecord(catatan: String, konsumsiObat: String, kualitasTidur: String, pasienID: CKRecord.ID, perubahanMood: String) {
        let newData = CKRecord(recordType: "PatientRecord")
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(catatan, forKey: "catatan")
        newData.setValue(kualitasTidur, forKey: "kualitasTidur")
        newData.setValue(reference, forKey: "pasienID")
        newData.setValue(perubahanMood, forKey: "perubahanMood")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    // MARK: - Load data to CloudKit
    
    func loadDoctorData(doctorID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "recordID = %@", doctorID)
        let query = CKQuery(recordType: "DoctorData", predicate: pred)
        
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
    
    func loadCommonMedicineData(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
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
    
    func loadRareMedicineData(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
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
