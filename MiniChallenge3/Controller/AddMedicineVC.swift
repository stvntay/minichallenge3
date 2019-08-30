//
//  AddMedicineVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 26/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class AddMedicineVC: UIViewController {

    @IBOutlet weak var addMedicineTitle: UILabel!
    @IBOutlet weak var medicineCategory: UITextField!
    @IBOutlet weak var medicineName: UITextField!
    @IBOutlet weak var medicineDescription: UITextField!
    @IBOutlet weak var medicineDosage: UITextField!
    @IBOutlet weak var medicineTime: UITextField!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        medicineCategory.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineName.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineTime.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineDescription.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        medicineDosage.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor(red:0.94, green:0.45, blue:0.37, alpha:1.0), width: 1)
        
        navBar.rightBarButtonItem = UIBarButtonItem(title: "Selesai", style: .done, target: self, action: #selector(onFinishTapped))
        medicineCategory.addTarget(self, action: #selector(chooseCategory), for: .touchDown)
    }
    
    @objc func chooseCategory(sender: UITextField){
        
    }
    
    @objc func onFinishTapped() {
        // do something
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
    }
}

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UITextField {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}
