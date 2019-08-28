//
//  ViewController.swift
//  MiniChallenge3
//
//  Created by Steven on 8/22/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
        let firstVC = storyboard.instantiateViewController(withIdentifier: "doctorView") 
        self.present(firstVC, animated: true, completion: nil)
//        let vc = DoctorOnBoardController()
//        navigationController?.pushViewController(vc, animated: true)
        
    }


}

