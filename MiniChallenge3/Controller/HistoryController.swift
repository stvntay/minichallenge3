//
//  HistoryController.swift
//  MiniChallenge3
//

//  Created by Finley Khouwira on 22/08/19.

//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class HistoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var historyView: HistoryView!
    
    let Months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    var DayAmouthInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let Days = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox: Int = 0
    var direction = 0
    var positionIndex = 3
    var leapYearCounter = 3
    var selectedSegment = 0
    
    lazy var selectedData = Months
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month - 1]
        
        startDateDayPosition()
        calendarUpdate()
        
        // month calendar label and current date label configuration
        historyView.monthLabel.text = "\(currentMonth) \(year)"
        historyView.currentDateLabel.text = "\(Days[day % 7]), \(day) \(currentMonth) \(year)"
        
        historyView.calendarView.isPagingEnabled = true
        
        // Calendar collection view and info table view delegate and data source
        historyView.calendarView.delegate = self
        historyView.calendarView.dataSource = self
        historyView.infoTableView.delegate = self
        historyView.infoTableView.dataSource = self
        
        historyView.previousBtn.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        historyView.nextBtn.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        
        historyView.segmentedControl.addTarget(self, action: #selector(handleSegmentedChange), for: .valueChanged)
        
        // Register XIB file to Table View
//        historyView.infoTableView.register(UINib(nibName: "MedicineTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineID")
        historyView.infoTableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityID")
        historyView.infoTableView.register(UINib(nibName: "SleepTableViewCell", bundle: nil), forCellReuseIdentifier: "SleepID")
        historyView.infoTableView.register(UINib(nibName: "ComplainTableViewCell", bundle: nil), forCellReuseIdentifier: "ComplainID")
        
        // Dynamic Cell
        historyView.infoTableView.estimatedRowHeight = 44
        historyView.infoTableView.rowHeight = UITableView.automaticDimension
        
        historyView.infoTableView.tableFooterView = UIView()
        
        // set image for calendar button
        historyView.nextBtn.setImage(UIImage(named: "Next"), for: .normal)
        historyView.nextBtn.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        historyView.previousBtn.setImage(UIImage(named: "Previous"), for: .normal)
        historyView.previousBtn.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        
        
        
        print(date)
        print(day)
        print(weekday)
        print(month)
        print(year)
    }
    
    // Back button function
    @objc func previousMonth(sender: UIButton) {
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
    
    // Next button function
    @objc func nextMonth(sender: UIButton) {
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
    
    // Function to fill out empty box in calendar
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
    
    // Set section of collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    // Set number of item in calendar per month
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
    
    // Cell congfiguration
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
    
    
    // Select Deselect configuration for calendar
    var selectedDate: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        collectionViewCell?.backgroundColor = #colorLiteral(red: 0.9541211724, green: 0.4644083977, blue: 0.4005665183, alpha: 1)
        collectionViewCell?.dateLabel.textColor = .white
        
        if indexPath.row - 1 == -1 {
            historyView.currentDateLabel.text = "\(Days[(indexPath.row) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(historyView.monthLabel.text!))"
        } else {
            historyView.currentDateLabel.text = "\(Days[(indexPath.row - 1) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(historyView.monthLabel.text!))"
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
    
    // Update function for calendar in month
    func calendarUpdate() {
        currentMonth = Months[month]
        
        historyView.monthLabel.text = "\(currentMonth) \(year)"
        historyView.calendarView.reloadData()
    }
    
    // Segmented control configuration
    @objc func handleSegmentedChange() {
        selectedSegment = historyView.segmentedControl.selectedSegmentIndex
        print(selectedSegment)
        
        if selectedSegment == 0 {
            selectedData = Months
        } else if selectedSegment == 1 {
            selectedData = Days
        } else if selectedSegment == 2 {
            selectedData = Months
        } else if selectedSegment == 3 {
            selectedData = Days
        }
        historyView.infoTableView.reloadData()
    }
    
    // Table View configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case 0:
            return selectedData.count
        case 1:
            return selectedData.count
        case 2:
            return 1
        case 3:
            return 1
        default:
            return selectedData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegment {
        case 0:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MedicineID") as? MedicineTableViewCell)!
            cell.medicineNameLabel.text = selectedData[indexPath.row]
            cell.doseLabel.text = selectedData[indexPath.row]
            return cell
        case 1:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "ActivityID") as? ActivityTableViewCell)!
            cell.activityLabel.text = selectedData[indexPath.row]
            cell.statusImage.image = UIImage.init(named: "Tergantung")
            return cell
        case 2:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SleepID") as? SleepTableViewCell)!
            cell.sleepLabel.text = selectedData[indexPath.row]
            return cell
        case 3:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "ComplainID") as? ComplainTableViewCell)!
            cell.complainLabel.text = selectedData[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineID") as! MedicineTableViewCell
            cell.medicineNameLabel.text = selectedData[indexPath.row]
            cell.doseLabel.text = selectedData[indexPath.row]
            return cell
        }
    }
    
}
