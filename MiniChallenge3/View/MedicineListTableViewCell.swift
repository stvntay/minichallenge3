//
//  MedicineListTableViewCell.swift
//  mc3_medicine
//
//  Created by Yosia on 26/08/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class MedicineListTableViewCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var beforeAfterMeal: UILabel!
    @IBOutlet weak var medicineAmount: UILabel!
    @IBOutlet weak var medicineTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
