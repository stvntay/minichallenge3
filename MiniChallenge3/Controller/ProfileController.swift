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
    var userRN = String()
    var doctorRN = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        let loadView = Load.shared.showLoad()
        self.present(loadView, animated: true, completion: nil)
        userRN = userDef.string(forKey: "userID") ?? "5187BE88-B4D8-4E65-B2D4-6D20663B6D6C"
        doctorRN = userDef.string(forKey: "doctorID") ?? "B1C05391-3D56-495F-9EF5-BBA996D534A0"
        
        view.layer.backgroundColor = UIColor.init(displayP3Red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        userTableView.separatorColor = .clear
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.isUserInteractionEnabled = false
        userDataView.layer.cornerRadius = 20
        userDataView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        userTableView.layer.cornerRadius = 20
        userTableView.isScrollEnabled = false
        
        doctorTableView.separatorColor = .clear
        doctorTableView.delegate = self
        doctorTableView.dataSource = self
        doctorTableView.isUserInteractionEnabled = false
        doctorDataView.layer.cornerRadius = 20
        doctorDataView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        doctorTableView.layer.cornerRadius = 20
        doctorTableView.isScrollEnabled = false
        
        let titleView = addTitleView(titleName: "no data")
        navigationController?.navigationBar.barTintColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.addSubview(titleView)
        

        ProfileModel.shared.loadMedicalID(userRN: userDef.string(forKey: "userID")!) { (result) in

            self.userContent = result
            self.userTableView.reloadData()
            self.navigationController?.navigationBar.viewWithTag(9)?.removeFromSuperview()
            let newTitleView = self.addTitleView(titleName: result.last?.value(forKey: "nama") as! String)
            self.navigationController?.navigationBar.addSubview(newTitleView)
        }
        ProfileModel.shared.loadPsikiaterData(doctorRN: userDef.string(forKey: "doctorID")!) { (result) in
            self.doctorContent = result
            self.doctorTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func addTitleView(titleName: String) -> UIView {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 132))
        let largeTitle = UILabel(frame: CGRect(x: 17, y: 40, width: 380, height: 40))
        let smallTitle = UILabel(frame: CGRect(x: 17, y: 80, width: 380, height: 20))
        largeTitle.text = titleName
        largeTitle.font = UIFont.boldSystemFont(ofSize: 34)
        largeTitle.textColor = .white
        smallTitle.text = "Homecare"
        smallTitle.font = UIFont.systemFont(ofSize: 17)
        smallTitle.textColor = .white
        titleView.tag = 9
        titleView.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        titleView.addSubview(largeTitle)
        titleView.addSubview(smallTitle)
        
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
            cell.contentLabel.font = UIFont.boldSystemFont(ofSize: 17)
            if indexPath.row == 0 {
                cell.contentLabel.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
            } else if indexPath.row == 2 {
                if (userContent.last?.value(forKey: userData[indexPath.row].key) as? Date) != nil {
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM dd, yyyy"
                    
                    let date: Date? = userContent.last?.value(forKey: userData[indexPath.row].key) as? Date
                    cell.contentLabel.text = dateFormatter.string(from: date!)
                }
            }
            
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
        return userDataView.frame.height/4
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 361, height: 70))
        let lineView = UIView(frame: CGRect(x: 0, y: 69, width: 361, height: 1))
        let headerLabel = UILabel(frame: CGRect(x: 17, y: 0, width: 200, height: 70))
        
        newView.backgroundColor = .white
        headerLabel.backgroundColor = .clear
        lineView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        headerLabel.text = "Profil Dokter"
//        headerLabel.textColor = UIColor(red: 239/255, green: 116/255, blue: 95/255, alpha: 1)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        newView.addSubview(headerLabel)
        newView.addSubview(lineView)
        
        return newView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == doctorTableView {
            return doctorDataView.frame.height - userDataView.frame.height/2
        } else {
            return 0
        }
    }

}
