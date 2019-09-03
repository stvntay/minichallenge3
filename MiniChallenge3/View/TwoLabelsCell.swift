//
//  TwoLabelsCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class TwoLabelsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
