//
//  ActivityPickerCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 31/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class ActivityPickerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    let activityOptions = ["Mandiri", "Bantuan", "Tergantung"]
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityValue: UILabel!
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var activityGuide: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityPicker.delegate = self
        activityPicker.dataSource = self
        activityGuide.layer.cornerRadius = 11
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activityValue.text = activityOptions[pickerView.selectedRow(inComponent: component)]
    }
}
