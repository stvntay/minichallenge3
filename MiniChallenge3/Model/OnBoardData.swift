//
//  OnBoardData.swift
//  MiniChallenge3
//
//  Created by Steven on 8/28/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

class OnBoardData{
    
    var doctorData: DoctorData
    var patientName: String
    var patientAge: String
    var dateRelease: String
    var patientAddress: String
    var hospitalName: String
    
    init(doctorData : DoctorData, name:String , age: String, date: String, address: String, hospital: String) {
        self.doctorData = doctorData
        patientName = name
        patientAge = age
        dateRelease = date
        patientAddress = address
        hospitalName = hospital
    }
}
