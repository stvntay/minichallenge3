//
//  ViewController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/22/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    var doctorID = CKRecord.ID()
    var userID = CKRecord.ID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("calling function...")
        CloudData.shared.savePsikiaterAndUserData(namaPsikiater: "bianka", nomorTelepon: "0821444444", alamat: "Jl A", namaUser: "Wilbert", tanggalLepasPasung: Date.distantFuture, umur: 14, puskesmas: "BSD") { (doctorID, userID) in
            self.doctorID = doctorID
            self.userID = userID
            print("doctorID: ", doctorID)
            print("userID: ", userID)
        }
    }


}

