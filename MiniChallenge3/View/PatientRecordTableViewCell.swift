//
//  PatientTableViewCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class PatientRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var fieldTitle: UILabel!
    @IBOutlet weak var fieldDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
