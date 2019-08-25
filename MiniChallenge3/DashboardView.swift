//
//  DashboardView.swift
//  MiniChallenge3
//
//  Created by Steven on 8/25/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class DashboardView: UIView {
    
    var data = [DashboardData]()

    @IBOutlet weak var addReport: UIButton!
    
    @IBOutlet weak var medicineList: UITableView!
    override func awakeFromNib() {
        medicineList.dataSource = self
        medicineList.delegate = self
        
        let nib = UINib.init(nibName: "DashboardCell", bundle: nil)
        self.medicineList.register(nib, forCellReuseIdentifier: "DashboardCell")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func getData(data: [DashboardData]){
        self.data = data
    }

}

extension DashboardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        
        return cell
    }
    
    
}
