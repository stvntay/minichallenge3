//
//  CreateRecordViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

let sectionTitle = ["Obat", "Aktivitas", "Tidur", "Keluhan"]
let rowPerSection = [0, 4, 1, 1] // change first number into the amount of medicine

struct RegularRowsContent {
    var medicineName: String
    var medicineFrequency: String
}

struct TextFieldRowsContent {
    var description: String
    var textFieldValue: String
}

struct SectionItem<RowContent> {
    var sectionTitle: String
    var rowsContent: RowContent
}

class CreateRecordViewController: UITableViewController {

    var medicineSection = [SectionItem<RegularRowsContent>]()
    var activitySection = [SectionItem<RegularRowsContent>]()
    var sleepSection = [SectionItem<TextFieldRowsContent>]()
    var commentSection = [SectionItem<TextFieldRowsContent>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UINib(nibName: "ActivityPickerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ActivityPicker")
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10 // replace with length of medicine list from CK
        }
        return rowPerSection[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(
            UINib(nibName: "ActivityPickerTableViewCell", bundle: Bundle.main),
            forCellReuseIdentifier: "reusableRecordCell"
        )
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "reusableRecordCell",
            for: indexPath
        ) as! TextFieldCell
        
//        if indexPath.section == 3 || indexPath.section == 2 {
//            tableView.register(
//                TextFieldCell.self,
//                forCellReuseIdentifier: "reusableRecordCell"
//            )
//            cell = tableView.dequeueReusableCell(
//                withIdentifier: "reusableRecordCell",
//                for: indexPath
//                ) as! TextFieldCell
//        } else {
//            tableView.register(
//                ActivityPickerTableViewCell.self,
//                forCellReuseIdentifier: "reusableRecordCell"
//            )
//            cell = tableView.dequeueReusableCell(
//                withIdentifier: "reusableRecordCell",
//                for: indexPath
//                ) as! ActivityPickerTableViewCell
//        }
        return cell
    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.isHidden ? 44 : 200
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
