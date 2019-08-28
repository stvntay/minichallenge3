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
    
    func saveMedicalID(alamat: String, nama: String, namaDokter: String, statusPerawatan: String, tanggalLepasPasung: Date, umur: Int, dokterID: CKRecord.ID) -> CKRecord.ID {
        let newData = CKRecord(recordType: "Users")
        var recordID = CKRecord.ID()
        let reference = CKRecord.Reference(recordID: dokterID, action: .deleteSelf)
        
        newData.setValue(alamat, forKey: "alamat")
        newData.setValue(nama, forKey: "nama")
        newData.setValue(reference, forKey: "dokterID")
        newData.setValue(tanggalLepasPasung, forKey: "tanggalLepasPasung")
        newData.setValue(umur, forKey: "umur")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                recordID = record!.recordID
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
        return recordID
        
    }
    
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
    
    func saveDoctorData(nama: String, namaPuskesmas: String, kodeVerifikasi: String) -> CKRecord.ID {
        let newData = CKRecord(recordType: "DoctorData")
        var recordID = CKRecord.ID()
        
        newData.setValue(nama, forKey: "nama")
        newData.setValue(namaPuskesmas, forKey: "namaPuskesmas")
        newData.setValue(kodeVerifikasi, forKey: "kodeVerifikasi")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                recordID = record!.recordID
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
        return recordID
        
    }
    
    func saveMedicineData(namaObat: String, dosisObat:String, jumlahPerHari: Int, setelahSebelumMakan: String, waktuMinum: [Date], pasienID: CKRecord.ID) {
        let newData = CKRecord(recordType: "MedicineData")
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(namaObat, forKey: "namaObat")
        newData.setValue(dosisObat, forKey: "dosisObat")
        newData.setValue(jumlahPerHari, forKey: "jumlahPerHari")
        newData.setValue(waktuMinum, forKey: "waktuMinum")
        newData.setValue(reference, forKey: "pasienID")
        
        CKContainer.default().publicCloudDatabase.save(newData) { (record, error) in
            if record != nil {
                print("save data success")
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    // MARK: - Load data to CloudKit
    
    func loadMedicalID(userID: CKRecord.ID) -> [CKRecord] {
        var data = [CKRecord]()
        
        let reference = CKRecord.Reference(recordID: userID, action: .deleteSelf)
        let pred = NSPredicate(format: "dokterID == %@", reference)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Users", predicate: pred)
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
