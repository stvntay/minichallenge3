//
//  ActivityMode.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 29/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

class activityModel {
    var activityName: String
    var status: String
    
    init(activity: String, status: String) {
        self.activityName = activity
        self.status = status
    }
}
