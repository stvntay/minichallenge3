//
//  RecordData.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 03/09/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

class RecordData {
    var medicineName: String
    var medicineDose: String
    var membersihkanDiri: String
    var makanDenganRapi: String
    var membersihkanPakaian: String
    var membersihkanRumah: String
    var berkomunikasiDenganLingkungan: String
    var sleep: String
    var complain: String
    
    init(medicineName: String , dose: String, membersihkanDiri: String, makanDenganRapi: String, membersihkanPakaian: String, membersihkanRumah: String, berkomunikasiDenganLingkungan: String, sleep: String, complain: String) {
        self.medicineName = medicineName
        self.medicineDose = dose
        self.membersihkanDiri = membersihkanDiri
        self.makanDenganRapi = makanDenganRapi
        self.membersihkanPakaian = membersihkanPakaian
        self.membersihkanRumah = membersihkanRumah
        self.berkomunikasiDenganLingkungan = berkomunikasiDenganLingkungan
        self.sleep = sleep
        self.complain = complain
    }
}
