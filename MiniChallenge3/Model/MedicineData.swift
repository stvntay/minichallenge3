//
//  MedicineData.swift
//  MiniChallenge3
//
//  Created by Steven on 9/2/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

class MedicineData {
    var medicineID: String
    var medicineCategory: String
    var medicineName: String
    var medicineDesc: String
    var medicineDose: String
    var medicineTime: String
    var medicineFreq: String
    
    init(ID: String,category: String ,name: String , desc: String, dose: String,freq: String, time: String) {
        medicineID = ID
        medicineCategory = category
        medicineName = name
        medicineDesc = desc
        medicineDose = dose
        medicineFreq = freq
        medicineTime = time
    }
}
