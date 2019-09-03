//
//  MedicineTableViewCell.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 29/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {

    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
