//
//  HistoryController.swift
//  MiniChallenge3
//
//  Created by Finley Khouwira on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: UICollectionView!
    
    @IBOutlet weak var addRecordBtn: UIBarButtonItem!
    
    let Months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    var DayAmouthInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let Days = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox: Int = 0
    var direction = 0
    var positionIndex = 0
    var leapYearCounter = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        
        monthLabel.text = "\(currentMonth) \(year)"

        self.dateLabel.text = "\(Days[day % 7]), \(day) \(currentMonth) \(year)"
        
        calendarView.isPagingEnabled = true
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        switch currentMonth {
        case "Januari":
            month = 11
            year -= 1
            direction = -1
            startDateDayPosition()
            calendarUpdate()
            
            if leapYearCounter > 0 {
                leapYearCounter -= 1
            }
            if leapYearCounter == 0 {
                DayAmouthInMonth[1] = 29
                leapYearCounter = 4
            } else {
                DayAmouthInMonth[1] = 28
            }
            
        default:
            month -= 1
            direction = -1
            startDateDayPosition()
            calendarUpdate()
        }
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        switch currentMonth {
        case "Desember":
            month = 0
            year += 1
            direction = 1
            startDateDayPosition()
            calendarUpdate()
            
            if leapYearCounter < 5 {
                leapYearCounter += 1
            }
            if leapYearCounter == 4 {
                DayAmouthInMonth[1] = 29
            }
            if leapYearCounter == 5 {
                leapYearCounter = 1
                DayAmouthInMonth[1] = 28
            }
            
        default:
            direction = 1
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
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
        cell.isHidden = false
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.layer.masksToBounds = true
        cell.isUserInteractionEnabled = true
        
        switch direction {
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1...:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 0,6,7,13,14,20,21,27,28,34,35:
            cell.dateLabel.textColor = .gray
        default:
            cell.dateLabel.textColor = .black
        }
        
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == calendar.component(.day, from: date) && indexPath.row + -3 == day {
            cell.dateLabel.textColor = .red
        }
        
        return cell
    }
    
    var selectedDate: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        collectionViewCell?.backgroundColor = #colorLiteral(red: 0.9541211724, green: 0.4644083977, blue: 0.4005665183, alpha: 1)
        collectionViewCell?.dateLabel.textColor = .white
        
        if indexPath.row - 1 == -1 {
            self.dateLabel.text = "\(Days[(indexPath.row) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(monthLabel.text!))"
        } else {
            self.dateLabel.text = "\(Days[(indexPath.row - 1) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(monthLabel.text!))"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        if indexPath.row % 7 == 0 || indexPath.row % 7 == 6 {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .gray
        } else if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == calendar.component(.day, from: date) && indexPath.row + -3 == day {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .red
        } else {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .black
        }
    }
    
    func calendarUpdate() {
        currentMonth = Months[month]
        
        monthLabel.text = "\(currentMonth) \(year)"
        calendarView.reloadData()
    }
}



