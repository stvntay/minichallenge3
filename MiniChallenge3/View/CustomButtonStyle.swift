//
//  CustomButtonStyle.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 28/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class CustomButtonStyle: UIButton {
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        
        backgroundColor = #colorLiteral(red: 0.9541211724, green: 0.4644083977, blue: 0.4005665183, alpha: 1)
        layer.cornerRadius = 5
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        clipsToBounds = true
        layer.masksToBounds = false
    }
    
}
