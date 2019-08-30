//
//  CreateRecordVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 29/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

var globalTemp: String!

class CreateRecordVC: UITableViewController {

    let ActivityPickerID = "ActivityPicker"
    var selectedIndexPath: IndexPath?
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ActivityPickerTableViewCell {
        
//        let itemData = dataArray[indexPath.row]
        let cellID = ActivityPickerID
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? ActivityPickerTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ActivityPickerTableViewCell
//        cell?.titleLabel.text = itemData[titleKey]
        
        // indexPath Check
//        if indexPath != selectedIndexPath {
//            if let globalTemp = globalTemp {
//                cell?.detailLabel.text = globalTemp
//                print("\(globalTemp)")
//            }
//        } else {
//            print("from else \(String(describing: globalTemp))")
//            // initialize value to default one.
//            cell?.pickerView.selectRow(1, inComponent: 0, animated: true)
//            cell?.pickerView.selectRow(30, inComponent: 1, animated: true)
//            cell?.detailLabel.text = "01min 30sec"
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths: Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: UITableView.RowAnimation.automatic)
        }
        
    }
    
    // observer
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! ActivityPickerTableViewCell).watchFrameChanges()
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! ActivityPickerTableViewCell).ignoreFrameChanges()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for cell in tableView.visibleCells {
            if cell.isKind(of: ActivityPickerTableViewCell.self) {
                (cell  as! ActivityPickerTableViewCell).ignoreFrameChanges()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return ActivityPickerTableViewCell.expandedHeight
        } else {
            return ActivityPickerTableViewCell.defaultheight
        }
    }
}
