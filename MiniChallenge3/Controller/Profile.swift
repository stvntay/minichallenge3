//
//  Profile.swift
//  MiniChallenge3
//
//  Created by I Putu Krisna on 02/09/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

enum userProfile {
    case nama
    case umur
    case alamat
    case tanggalLepasPasung
    case puskesmas
    
    var title: String {
        switch self {
        case .nama:
            return "Nama"
        case .umur:
            return "Umur"
        case .alamat:
            return "Alamat"
        case .tanggalLepasPasung:
            return "Tanggal Lepas Pasung"
        case .puskesmas:
            return "Nama Puskesmas/Rumah Sakit"
        }
    }
    var key: String {
        switch self {
        case .nama:
            return "nama"
        case .umur:
            return "umur"
        case .alamat:
            return "alamat"
        case .tanggalLepasPasung:
            return "tanggalLepasPasung"
        case .puskesmas:
            return "puskesmas"
        }
    }
}

enum doctorProfile {
    case nama
    case nomorTelepon
    
    var title: String {
        switch self {
        case .nama:
            return "Nama Dokter"
        case .nomorTelepon:
            return "No. Telepon"
        }
    }
    var key: String {
        switch self {
        case .nama:
            return "nama"
        case .nomorTelepon:
            return "nomorTelepon"
        }
    }
}
