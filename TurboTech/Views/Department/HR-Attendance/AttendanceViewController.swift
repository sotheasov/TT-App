//
//  AttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import IBPCollectionViewCompositionalLayout

class AttendanceViewController: UIViewController {
    
    // IBOutlet of AttendanceViewController
    @IBOutlet weak var attendanceProfileImageView: UIImageView!
    @IBOutlet weak var attendanceCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Declare Variable
    let data = ["1", "2", "3", "4"]
    var estimateWidth = 200.0
    var cellMarginSize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attendanceCollectionView.delegate = self
        attendanceCollectionView.dataSource = self
        
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        self.view.backgroundColor = UIColor(red: 0.20, green: 0.67, blue: 0.88, alpha: 1.00)
        
        
        // Register Attendance CollectionViewCell
        attendanceCollectionView.register(UINib(nibName: "AttendanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "attendanceCellItem")
        
        // Call Function
        customAttendanceViewController()
        setupGridView()
//        setCollectionLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupGridView()
        DispatchQueue.main.async {
            self.attendanceCollectionView.reloadData()
        }
    }
    
    func setupGridView() {
        let flow = attendanceCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    func customAttendanceViewController() {
        attendanceProfileImageView.layer.cornerRadius = attendanceProfileImageView.frame.height/2
        attendanceProfileImageView.layer.borderWidth = 2
        attendanceProfileImageView.layer.borderColor = COLOR.RED.cgColor
    }
    
    // Action Button
    @IBAction func buttonBackPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AttendanceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceCellItem", for: indexPath) as! AttendanceCollectionViewCell
//        cell.setData(text: self.data[indexPath.row])
        if indexPath.item % 2 == 0 {
            cell.setConstraint(right: true)
        } else {
            cell.setConstraint(right: false)
        }
        cell.coverAttendanceViewCell.setColorGradient(colorOne: COLOR.RED, colorTwo: COLOR.BLUE)
        return cell
    }
    
//    func setCollectionLayout() {
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 1, height: 145)
//        layout.minimumInteritemSpacing = 1
//        layout.minimumLineSpacing = 1
//        attendanceCollectionView.collectionViewLayout = layout
//    }
}

extension AttendanceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
//        let width = self.set()
        if indexPath.item == 0 || indexPath.item == 3 {        
            return CGSize(width: (self.view.frame.width / 2), height: 270)
        }
        else {
            return CGSize(width: (self.view.frame.width / 2), height: 200)
        }
    }
    
    func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimatedWidth)
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / floor(2.0)
        return width
    }
}
