//
//  PatientOnBoardView.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class PatientOnBoardView: UIView {

    @IBOutlet weak var namePatientInput: UITextField!
    @IBOutlet weak var agePatientInput: UITextField!
    @IBOutlet weak var releaseDateInput: UITextField!
    @IBOutlet weak var addressPatientInput: UITextField!
    
    override func awakeFromNib() {
        namePatientInput.clearButtonMode = UITextField.ViewMode.whileEditing
        agePatientInput.clearButtonMode = UITextField.ViewMode.whileEditing
        releaseDateInput.clearButtonMode = UITextField.ViewMode.whileEditing
        addressPatientInput.clearButtonMode = UITextField.ViewMode.whileEditing
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
