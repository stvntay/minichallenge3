//
//  ProfileController.swift
//  MiniChallenge3
//
//  Created by I Putu Krisna on 02/09/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userDataView: UIView!
    @IBOutlet weak var doctorDataView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var doctorTableView: UITableView!
    
    let userDef = UserDefaults.standard
    let userData = [userProfile.umur, userProfile.alamat, userProfile.tanggalLepasPasung, userProfile.puskesmas]
    let doctorData = [doctorProfile.nama, doctorProfile.nomorTelepon]
    var userContent  = [CKRecord]()
    var doctorContent = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let userID = userDef.value(forKey: "userID") as! CKRecord.ID
        let userID = CKRecord.ID(recordName: "5187BE88-B4D8-4E65-B2D4-6D20663B6D6C")
//        let doctorID = userDef.value(forKey: "doctorID") as! CKRecord.ID
        let doctorID = CKRecord.ID(recordName: "B1C05391-3D56-495F-9EF5-BBA996D534A0")
        
        view.layer.backgroundColor = UIColor.init(displayP3Red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        userTableView.separatorColor = .clear
        userTableView.delegate = self
        userTableView.dataSource = self
        userDataView.layer.cornerRadius = 20
        userTableView.layer.cornerRadius = 20
        userTableView.isScrollEnabled = false
        doctorTableView.separatorColor = .clear
        doctorTableView.delegate = self
        doctorTableView.dataSource = self
        doctorDataView.layer.cornerRadius = 20
        doctorTableView.layer.cornerRadius = 20
        doctorTableView.isScrollEnabled = false
        
        ProfileModel.shared.loadMedicalID(userID: userID) { (result) in
            self.userContent = result
            self.userTableView.reloadData()
        }
        ProfileModel.shared.loadPsikiaterData(doctorID: doctorID) { (result) in
            self.doctorContent = result
            self.doctorTableView.reloadData()
        }
        
        let newView = addTitleView()
        view.addSubview(newView)
        
    }
    
    func addTitleView() -> UIView {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 180))
        let textView = UIView(frame: CGRect(x: 0, y: 100, width: 361, height: 80))
        let largeLabel = UILabel(frame: CGRect(x: 17, y: 0, width: 200, height: 40))
        let smallLabel = UILabel(frame: CGRect(x: 17, y: 40, width: 200, height: 20))
        
        textView.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        largeLabel.text = "\(userContent.last?.value(forKey: "nama") ?? "no data")"
        largeLabel.font = UIFont.boldSystemFont(ofSize: 34)
        largeLabel.textColor = .white
        smallLabel.text = "Homecare"
        smallLabel.font = UIFont.systemFont(ofSize: 17)
        smallLabel.textColor = .white
        titleView.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        textView.addSubview(largeLabel)
        textView.addSubview(smallLabel)
        titleView.addSubview(textView)
        
        return titleView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userTableView {
            return userData.count
        } else {
            return doctorData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == userTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserProfileCell
            cell.titleLabel.text = userData[indexPath.row].title
            cell.titleLabel.font = UIFont.systemFont(ofSize: 12)
            cell.contentLabel.text = "\(userContent.first?.value(forKey: userData[indexPath.row].key) ?? "no data")"
//            print(indexPath.row)
            cell.contentLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! DoctorProfileCell
            cell.titleLabel.text = doctorData[indexPath.row].title
            cell.titleLabel.font = UIFont.systemFont(ofSize: 12)
            cell.contentLabel.text = "\(doctorContent.first?.value(forKey: doctorData[indexPath.row].key) ?? "no data")"
            cell.contentLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 361, height: 60))
        let lineView = UIView(frame: CGRect(x: 0, y: 55, width: 361, height: 1))
        let headerLabel = UILabel(frame: CGRect(x: 17, y: 0, width: 200, height: 60))
        
        newView.backgroundColor = .white
        headerLabel.backgroundColor = .clear
        lineView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        headerLabel.text = "Profil Dokter"
        headerLabel.textColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        newView.addSubview(headerLabel)
        newView.addSubview(lineView)
        
        return newView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == doctorTableView {
            return 60
        } else {
            return 0
        }
    }

}
