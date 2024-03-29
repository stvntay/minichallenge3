//
//  HistoryController.swift
//  MiniChallenge3
//

//  Created by Finley Khouwira on 22/08/19.

//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit
import CloudKit

class HistoryController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var historyView: HistoryView!
    
    let Months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    var DayAmouthInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let Days = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
    let activityQ = ["Membersihkan Diri", "Makan Dengan Rapi", "Membersihkan Pakaian", "Membersihkan Rumah", "Berkomunikasi Dengan Lingkungan"]
    var currentMonth = String()
    var indexCell = IndexPath()
    var recordData: [RecordData] = []
    
    var numberOfEmptyBox = Int()
    var nextNumberOfEmptyBox = Int()
    var previousNumberOfEmptyBox: Int = 0
    var direction = 0
    var positionIndex = 3
    var leapYearCounter = 3
    var selectedSegment = 0
    var historyMedicine = [[String]]()
    var historyActivity = [String]()
    var historySleep = [String]()
    var historyComplain = [String]()
    lazy var selectedData = Months
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(calendar)

        currentMonth = Months[month - 1]
        
        startDateDayPosition()
        calendarUpdate()
        
        // month calendar label and current date label configuration
        historyView.monthLabel.text = "\(currentMonth) \(year)"
        historyView.currentDateLabel.text = "\(Days[day - 2 % 7]), \(day) \(currentMonth) \(year)"
        
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
        
//        let addImg = UIImage(named: "plusRiwayat")

        let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createRecordPage))
        addbutton.tintColor = #colorLiteral(red: 1, green: 0.4196078431, blue: 0.3411764706, alpha: 1)
        navigationItem.rightBarButtonItem = addbutton
        navigationItem.title = "Riwayat"
        
        print("date: ", date)
        print(day)
        print(weekday)
        print(month)
        print(year)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let dateCreated = dateFormatter.string(from: date)
        
//        let loadingView = Load.shared.showLoad()
//        self.present(loadingView, animated: true, completion: nil)
        HistoryModel.shared.loadMedicalRecord(userRN: UserDefaults.standard.string(forKey: "userID")!, dateClicked: dateCreated) { (result) in
            if result.count != 0 {
                self.parseHistoryData(records: result, completion: { (status) in
                    print(status)
                    if status {
                        self.historyView.infoTableView.reloadData()
                    } else {
                        print(status)
                    }
                })
            }
//            loadingView.dismiss(animated: true, completion: nil)
//            loadingView.removeFromParent()
        }
//        RecordModel.shared.saveMedicalRecord(namaObat: ["ana", "ani", "anu"], obat: ["1x", "2x", "3x"], membersihkanDiri: "Mandiri", makanDenganRapi: "Bersama", membersihkanPakaian: "Mandiri", membersihkanRumah: "Bersama", berkomunikasiDenganLingkungan: "Tergantung", tidurHariIni: "ff", catatan: "gg", pasienRN: UserDefaults.standard.string(forKey: "userID")!) { (result) in
//            print(result)
//        }
    }
    
    // go to create record
    @objc func createRecordPage(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "CreateRecord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateRecordTableVC")
        self.navigationController?.pushViewController(vc, animated: true)
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
                numberOfEmptyBox = (weekday - day) % 7
            case 8...14:
                numberOfEmptyBox = (weekday - day - 7) % 7
            case 15...21:
                numberOfEmptyBox = (weekday - day - 14) % 7
            case 22...28:
                numberOfEmptyBox = (weekday - day - 21) % 7
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
        collectionView.isScrollEnabled = false
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
        
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == calendar.component(.day, from: date) && indexPath.row + 1 == day{
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            print("indexPath: ", indexPath)
            if indexPath[0] == 0 {
                indexCell = indexPath
                cell.dateLabel.textColor = .white
                cell.backgroundColor = #colorLiteral(red: 0.9541211724, green: 0.4644083977, blue: 0.4005665183, alpha: 1)
            }
        }
        
        return cell
    }
    
    
    // Select Deselect configuration for calendar
    var selectedDate: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let prevCell = collectionView.cellForItem(at: indexCell) as? DateCollectionViewCell
        prevCell?.dateLabel.textColor = .red
        prevCell?.backgroundColor = .clear
        print("indexCell: ", indexCell)
        let collectionViewCell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        collectionViewCell?.backgroundColor = #colorLiteral(red: 0.9541211724, green: 0.4644083977, blue: 0.4005665183, alpha: 1)
        collectionViewCell?.sizeToFit()
        collectionViewCell?.dateLabel.textColor = .white
        
//        let loadView = Load.shared.showLoad()
//        self.present(loadView, animated: true, completion: nil)
        if indexPath.row - 1 == -1 {
            historyView.currentDateLabel.text = "\(Days[(indexPath.row) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(historyView.monthLabel.text!))"
            
            guard let monthText = historyView.monthLabel.text else {
                return
            }
            let range = monthText.startIndex..<monthText.index(monthText.startIndex, offsetBy: 3)
            let thisMonth = monthText[range]
            guard var thisDate = collectionViewCell?.dateLabel.text else { return }
            if Int(thisDate)! < 10 {
                thisDate = "0\(thisDate)"
            }
            let thisYear = year
            let dateClicked = "\(thisMonth) \(thisDate), \(thisYear)"
            print(dateClicked)
            
//            let loadingView = Load.shared.showLoad()
//            self.present(loadingView, animated: true, completion: nil)
            HistoryModel.shared.loadMedicalRecord(userRN: UserDefaults.standard.string(forKey: "userID")!, dateClicked: dateClicked) { (result) in
                if result.count != 0 {
                    self.parseHistoryData(records: result, completion: { (status) in
                        print(status)
                        if status {
                            self.historyView.infoTableView.reloadData()
                        } else {
                            print(status)
                        }
                    })
                }
                // dismis alert
//                loadingView.dismiss(animated: true, completion: nil)
//                loadingView.removeFromParent()
                //            print(result)
            }
        } else {
            historyView.currentDateLabel.text = "\(Days[(indexPath.row - 1) % 7]), \(String((collectionViewCell?.dateLabel.text!)!)) \(String(historyView.monthLabel.text!))"
            
            guard let monthText = historyView.monthLabel.text else {
                return
            }
            let range = monthText.startIndex..<monthText.index(monthText.startIndex, offsetBy: 3)
            let thisMonth = monthText[range]
            guard var thisDate = collectionViewCell?.dateLabel.text else { return }
            if Int(thisDate)! < 10 {
                thisDate = "0\(thisDate)"
            }
            let thisYear = year
            let dateClicked = "\(thisMonth) \(thisDate), \(thisYear)"
            print(dateClicked)
            
            let loadingView = Load.shared.showLoad()
            self.present(loadingView, animated: true, completion: nil)
            HistoryModel.shared.loadMedicalRecord(userRN: UserDefaults.standard.string(forKey: "userID")!, dateClicked: dateClicked) { (result) in
                print("executed")
                print("result: ", result)
                if result.count != 0 {
                    self.parseHistoryData(records: result, completion: { (status) in
                       print(status)
                        if status {
                            print("process done")
                            self.historyView.infoTableView.reloadData()
                        } else {
                            
                        }
                    })
                } else {
                    self.historyMedicine.removeAll()
                    self.historyActivity.removeAll()
                    self.historySleep.removeAll()
                    self.historyComplain.removeAll()
                }
                // dismis alert
                loadingView.dismiss(animated: true, completion: nil)
                loadingView.removeFromParent()
                //            print(result)
                self.historyView.infoTableView.reloadData()
            }
        }

        // show alert
    }
    
    func parseHistoryData(records: [CKRecord],
                          completion: @escaping(Bool) -> Void) {
        let data = records.last
        self.historyMedicine.removeAll()
        self.historyActivity.removeAll()
        self.historySleep.removeAll()
        self.historyComplain.removeAll()
        
        self.historyMedicine.append(data?["namaObat"] as! [String])
        self.historyMedicine.append(data?["obat"] as! [String])
        self.historyActivity.append(data?["membersihkanDiri"] as! String)
        self.historyActivity.append(data?["makanDenganRapi"] as! String)
        self.historyActivity.append(data?["membersihkanPakaian"] as! String)
        self.historyActivity.append(data?["membersihkanRumah"] as! String)
        self.historyActivity.append(data?["berkomunikasiDenganLingkungan"] as! String)
        self.historySleep.append(data?["tidurHariIni"] as! String)
        self.historyComplain.append(data?["catatan"] as! String)
        
//        self.historyView.infoTableView.reloadData()
        
        print(historyMedicine)
        completion(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let collectionViewCell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell
        if indexPath.row % 7 == 0 || indexPath.row % 7 == 6 {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .gray
        } else if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && day == calendar.component(.day, from: date) && indexPath.row + 1 == day {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .red // MARK: - this------------------
        } else {
            collectionViewCell?.backgroundColor = .clear
            collectionViewCell?.dateLabel.textColor = .black
        }
    }
    
    // Update function for calendar in month
    func calendarUpdate() {
        currentMonth = Months[month - 1]
        
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
            if historyMedicine.count > 0 {
                return historyMedicine[0].count
            } else {
                return 1
            }
          
        case 1:
            if historyActivity.count > 0 {
                return historyActivity.count
            } else {
                return 1
            }
        case 2:
            if historyActivity.count > 0 {
                return historySleep.count
            } else {
                return 1
            }
        case 3:
            if historyActivity.count > 0 {
                return historyComplain.count
            } else {
                return 1
            }
        default:
            return recordData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegment {
        case 0:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "MedicineID") as? MedicineTableViewCell)!
            if historyMedicine.count > 0 {
                cell.medicineNameLabel.text = historyMedicine[0][indexPath.row]
                cell.doseLabel.text = historyMedicine[1][indexPath.row]
            } else {
                cell.medicineNameLabel.text = "Belum ada catatan"
                cell.doseLabel.text = ""
            }
            return cell
        case 1:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "ActivityID") as? ActivityTableViewCell)!
            if historyActivity.count > 0 {
                cell.activityLabel.text = activityQ[indexPath.row]
                print(historyActivity[indexPath.row])
                cell.statusImage.image = UIImage.init(named: historyActivity[indexPath.row] )
            } else {
                cell.activityLabel.text = "Belum ada catatan"
//                cell.statusImage.image = UIImage.init(named: historyActivity[indexPath.row] )
            }
            return cell
        case 2:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "SleepID") as? SleepTableViewCell)!
            if historySleep.count > 0 {
                cell.sleepLabel.text = historySleep[indexPath.row]
            } else {
                cell.sleepLabel.text = "Belum ada catatan"
            }
            return cell
        case 3:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "ComplainID") as? ComplainTableViewCell)!
            if historyComplain.count > 0 {
                cell.complainLabel.text = historyComplain[indexPath.row]
            } else {
                cell.complainLabel.text = "Belum ada catatan"
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineID") as! MedicineTableViewCell
            cell.medicineNameLabel.text = selectedData[indexPath.row]
            cell.doseLabel.text = selectedData[indexPath.row]
            return cell
        }
    }
    
}
