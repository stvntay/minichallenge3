//
//  HistoryController.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: UICollectionView!
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let DayAmouthInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let Days = ["Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday", "Sunday"]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox: Int = 0
    var direction = 0
    var positionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        
        monthLabel.text = "\(currentMonth) \(year)"
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            direction = 1
            startDateDayPosition()
            calendarUpdate()
        default:
            direction = 1
            startDateDayPosition()
            month -= 1
            calendarUpdate()
        }
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            direction = -1
            startDateDayPosition()
            calendarUpdate()
        default:
            direction = -1
            startDateDayPosition()
            month += 1
            calendarUpdate()
        }
    }
    
    func startDateDayPosition() {
        switch direction {
        case 0:
            switch day {
            case 1...7:
                numberOfEmptyBox = weekday - day
            case 8...14:
                numberOfEmptyBox = weekday - day - 7
            case 15...21:
                numberOfEmptyBox = weekday - day - 14
            case 22...28:
                numberOfEmptyBox = weekday - day - 21
            case 29...31:
                numberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            positionIndex = numberOfEmptyBox
        case 1:
            nextNumberOfEmptyBox = (positionIndex + DayAmouthInMonth[month]) % 7
            positionIndex = nextNumberOfEmptyBox
        case -1:
            previousNumberOfEmptyBox = (7 - (DayAmouthInMonth[month] - positionIndex) % 7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch direction {
        case 0:
            return DayAmouthInMonth[month] + numberOfEmptyBox
        case 1:
            return DayAmouthInMonth[month] + nextNumberOfEmptyBox
        case -1:
            return DayAmouthInMonth[month] + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = .clear
        switch direction {
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        
        return cell
    }
    
    func calendarUpdate() {
        currentMonth = Months[month]
        
        monthLabel.text = "\(currentMonth) \(year)"
        calendarView.reloadData()
    }
}



