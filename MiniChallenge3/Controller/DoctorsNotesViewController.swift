//
//  DoctorsNotesViewController.swift
//  MiniChallenge3
//
//  Created by Yosia on 22/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class DoctorsNotesViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doctorsNoteTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(
            title: "Kembali",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(self.backButtonPressed)
        )
        
        navigationItem.leftBarButtonItem = backButton
        navigationBar.topItem?.title = "Catatan Dokter"
        textView.isEditable = false
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
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
