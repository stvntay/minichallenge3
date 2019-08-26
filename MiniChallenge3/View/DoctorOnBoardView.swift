//
//  DoctorOnBoardView.swift
//  MiniChallenge3
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class DoctorOnBoardView: UIView {

    @IBOutlet weak var doctorNameInput: UITextField!
    @IBOutlet weak var hospitalNameInput: UITextField!
    @IBOutlet weak var verifCodeInput: UITextField!
    @IBOutlet weak var nextPageBtn: UIButton!
    
    
    override func awakeFromNib() {
        
        doctorNameInput.clearButtonMode = UITextField.ViewMode.whileEditing
        hospitalNameInput.clearButtonMode = UITextField.ViewMode.whileEditing
        verifCodeInput.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
