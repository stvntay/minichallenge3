//
//  DashboardController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/22/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {

    @IBOutlet var dashboardView: DashboardView!
    var data = [DashboardData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView.getData(data: data)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setNavigation()
    }
    
    func setNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Dashboard"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
