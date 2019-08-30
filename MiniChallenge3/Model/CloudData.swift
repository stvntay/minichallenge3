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
    
    func savePsikiaterData(nama: String, nomorTelepon: String, completion: @escaping (_ recID: CKRecord.ID) -> Void) {
        let newData = CKRecord(recordType: "PsikiaterData")
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
    
    func savePsikiaterAndUserData(namaPsikiater: String, nomorTelepon: String, alamat: String, namaUser: String, tanggalLepasPasung: Date, umur: Int, puskesmas: String, completion: @escaping (_ doctorID: CKRecord.ID, _ userID: CKRecord.ID) -> Void) {
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
                                completion(recordDoctorID, recordUserID)
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
    
    func saveRareMedichineData(namaObat: String, deskripsiObat: String, dosisObat:String, setelahSebelumMakan: String, pasienID: CKRecord.ID) {
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
    func saveMedicalRecord(obatA: String, obatB: String, membersihkanDiri: String, makanDenganRapi: String, membersihkanPakaian: String, membersihkanRumah: String, berkomunikasiDenganLingkungan: String, tidurHariIni: String, catatan: String, pasienID: CKRecord.ID) {
        let newData = CKRecord(recordType: "MedicalRecord")
        let reference = CKRecord.Reference(recordID: pasienID, action: .deleteSelf)
        
        newData.setValue(obatA, forKey: "obatA")
        newData.setValue(obatB, forKey: "obatB")
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
    
    func loadRareMedicalRecord(userID: CKRecord.ID, completion: @escaping (_ recID: [CKRecord]) -> Void) {
        let pred = NSPredicate(format: "pasienID = %@", userID)
        let query = CKQuery(recordType: "MedicalRecord", predicate: pred)
        
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
