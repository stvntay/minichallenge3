//
//  CalenderView.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

var day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)
