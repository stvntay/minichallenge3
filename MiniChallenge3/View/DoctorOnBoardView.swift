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
    
    @IBOutlet weak var telephoneDoctor: UITextField!

    
    
    override func awakeFromNib() {
        
        doctorNameInput.clearButtonMode = UITextField.ViewMode.whileEditing
        telephoneDoctor.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
