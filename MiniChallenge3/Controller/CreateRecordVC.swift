//
//  CreateRecordVC.swift
//  MiniChallenge3
//
//  Created by Yosia on 27/08/19.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

class CreateRecordVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questionBox: UITextView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var options = [
        [
            "Satu",
            "Dua",
            "Tiga"
        ],
        [
            "A",
            "B",
            "C"
        ]
    ]
    var questions = ["Kenapa?", "Mengapa"]
    var selector = 0
    
    var cellSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 55)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionBox.text = questions[selector]
        
        self.optionsCollectionView.dataSource = self
        self.optionsCollectionView.delegate = self
        optionsCollectionView.register(UINib(nibName: "CreateRecordOptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "optionCell")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = Int(UIScreen.main.bounds.width * 0.8) * options[selector].count // width ngasal
        let totalSpacingWidth = 5 * (options[selector].count - 1)
        
        let leftInset = ((self.view.frame.width * 0.8) - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options[selector].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as! CreateRecordOptionCollectionViewCell
        cell.optionLabel.text = options[selector][indexPath.row]
        cell.layer.cornerRadius = 24
        return cell
    }
    
    @IBAction func onNextTapped(_ sender: Any) {
        selector += 1
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
