//
//  MedicineData.swift
//  MiniChallenge3
//
//  Created by Steven on 9/2/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

class MedicineData {
    var medicineName: String
    var medicineDesc: String
    var medicineDose: String
    var medicineTime: String
    
    init(name: String , desc: String, dose: String, time: String) {
        medicineName = name
        medicineDesc = desc
        medicineDose = dose
        medicineTime = time
    }
}
