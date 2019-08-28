//
//  CreateRecordOptionCollectionViewCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 27/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class CreateRecordOptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    var customRed = UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isSelected: Bool {
        didSet {
            if isSelected { // Selected cell
                self.backgroundColor = customRed
                self.optionLabel.textColor = .white
            } else { // Normal cell
                self.backgroundColor = .white
                self.optionLabel.textColor = customRed
            }
        }
    }
}
