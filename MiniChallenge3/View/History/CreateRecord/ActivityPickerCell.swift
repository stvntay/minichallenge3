//
//  ActivityPickerCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 31/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class ActivityPickerCell: UITableViewCell {
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
