//
//  TranslationTableViewCell.swift
//  MC2 Dictionary
//
//  Created by wimba prasiddha on 17/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import AVFoundation

class TranslationTableViewCell: UITableViewCell {

    @IBOutlet weak var videoTap: UIView!
    @IBOutlet weak var terjemahan: UILabel!
    @IBOutlet weak var videoTerjemahan: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoTap.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapVideo))
        tap.numberOfTapsRequired = 1
        videoTap.addGestureRecognizer(tap)
    }

    @objc func tapVideo(sender : UITapGestureRecognizer){
        print("videoTap")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
