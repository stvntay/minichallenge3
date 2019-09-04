//
//  ActivityRecordHeader.swift
//  MiniChallenge3
//
//  Created by Yosia on 04/09/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class ActivityRecordHeader: UITableViewHeaderFooterView {
    let image = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            image.widthAnchor.constraint(equalToConstant: 23),
            image.heightAnchor.constraint(equalToConstant: 23),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
