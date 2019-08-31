//
//  TextFieldCell.swift
//  MiniChallenge3
//
//  Created by Yosia on 30/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var textInput: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textInput.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the t
        textInput.text = textView.text
    }
}
