//
//  AttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 5/27/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import PinterestLayout

class AttendanceViewController: UIViewController {
    
    // IBOutlet of AttendanceViewController
    @IBOutlet weak var attendanceProfileImageViewOutlet: UIImageView!
    @IBOutlet weak var lbOverView: UILabel!
    @IBOutlet weak var btnBackAttendanceOutlet: UIButton!
    @IBOutlet weak var lbTopAttendanceOutlet: UILabel!
    @IBOutlet weak var lbBottomAttendanceOutlet: UILabel!
    @IBOutlet weak var attendanceCollectionViewOutlet: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Declare Variable
    var data = [0, 0, -1, 0]
    let cellLayout = PinterestLayout()
    let attandanceViewModel = AttandanceViewModel()
    
    var presentList = [PresentAttendance]()
    var lateList = [PresentAttendance]()
    var absenceList = [AbsenceAttendance]()
    var overallList = [AttendanceProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call Function
        customAttendanceViewController()
        registerCollectionViewCell()
        getCurrentDateTime()
        getSingle()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-dd"
        // "yyyy-M-dd"
        // 2020-01-01
        // Jan 01, 2020
        
        let str = formatter.string(from: Date())
        print("TOT API : ", str)
        let date = str
        DispatchQueue.main.async {
            self.attandanceViewModel.fetchPresentAttandance(date: date) { (presentList) in
                self.data[0] = presentList.count
                self.presentList = presentList
                self.attendanceCollectionViewOutlet.reloadData()
            }
            self.attandanceViewModel.fetchLateAttandance(date: date) { (lateList) in
                self.data[1] = lateList.count
                self.lateList = lateList
                self.attendanceCollectionViewOutlet.reloadData()
            }
            self.attandanceViewModel.fetchAbsneceAttandance(date: date) { (absenceList) in
                self.data[3] = absenceList.count
                self.absenceList = absenceList
                self.attendanceCollectionViewOutlet.reloadData()
            }
            self.attandanceViewModel.fectchOverall(date: date) { (overallList) in
                self.overallList = overallList
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.attendanceCollectionViewOutlet.reloadData()
        }
    }
    
    func registerCollectionViewCell()  {
        attendanceCollectionViewOutlet.register(UINib(nibName: "AttendanceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "attendanceCellItem")
        attendanceCollectionViewOutlet.delegate = self
        attendanceCollectionViewOutlet.dataSource = self
        attendanceCollectionViewOutlet.collectionViewLayout = cellLayout
        cellLayout.delegate = self
        cellLayout.cellPadding = 0
        cellLayout.numberOfColumns = 2
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        // "yyyy-M-dd"
        // 2020-01-01
        // Jan 01, 2020
        let str = formatter.string(from: Date())
        lbOverView.text = str
    }
    
    func getSingle(){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        print("\(year):\(month):\(day)")
    }
    
    func customAttendanceViewController() {
        attendanceProfileImageViewOutlet.layer.cornerRadius = attendanceProfileImageViewOutlet.frame.height/2
        attendanceProfileImageViewOutlet.layer.borderWidth = 3
        attendanceProfileImageViewOutlet.layer.borderColor = COLOR.WHITE_SMOKE_GREY.cgColor
        
        btnBackAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        lbTopAttendanceOutlet.textColor = COLOR.COLOR_PRESENT
        lbBottomAttendanceOutlet.textColor = COLOR.COLOR_PRESENT
        
    }
    
    // Action Button
    @IBAction func btnBackAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: SovSothea
extension AttendanceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attendanceCellItem", for: indexPath) as! AttendanceCollectionViewCell
        cell.numberAttendanceLabelOutlet.text = "\(data[indexPath.item])"
        if cell.frame.maxX > (self.attendanceCollectionViewOutlet.frame.width / 2) {
            cell.coverAttendanceViewCellOutlet.backgroundColor = COLOR.COLOR_LATE
            cell.trailingCoverConstraintOutlet.constant = 32
            cell.leadingCoverConstraintOutlet.constant = 10
            
        }
        else {
            cell.coverAttendanceViewCellOutlet.backgroundColor = COLOR.COLOR_ABSENCE
            cell.trailingCoverConstraintOutlet.constant = 10
            cell.leadingCoverConstraintOutlet.constant = 32
        }
        // Add GestureRecognizer
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    @objc
    func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.attendanceCollectionViewOutlet)
        let indexPath = self.attendanceCollectionViewOutlet.indexPathForItem(at: location)
        if let index = indexPath {
            print("Got clicked on index: \(index)!")
            switch index.item {
            case 0:
                let presentAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "PresentAttendanceViewControllerID") as! PresentAttendanceViewController
                presentAttendanceVC.modalPresentationStyle = .fullScreen
                presentAttendanceVC.presentList = presentList
                presentAttendanceVC.overallList = overallList
                self.showDetailViewController(presentAttendanceVC, sender: nil)
                self.navigationController?.pushViewController(presentAttendanceVC, animated: true)
            case 1:
                let lateAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "LateAttendanceViewControllerID") as! LateAttendanceViewController
                lateAttendanceVC.modalPresentationStyle = .fullScreen
                lateAttendanceVC.lateList = lateList
                lateAttendanceVC.overallList = overallList
                self.showDetailViewController(lateAttendanceVC, sender: nil)
                self.navigationController?.pushViewController(lateAttendanceVC, animated: true)
            case 2:
                let totalVC = storyboard?.instantiateViewController(withIdentifier: "TotalAttendanceViewControllerID") as! TotalAttendanceViewController
                totalVC.modalPresentationStyle = .fullScreen
                self.showDetailViewController(totalVC, sender: nil)
                self.navigationController?.pushViewController(totalVC, animated: true)
            case 3:
                let absenceAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "AbsenceAttendanceViewControllerID") as! AbsenceAttendanceViewController
                absenceAttendanceVC.modalPresentationStyle = .fullScreen
                absenceAttendanceVC.absenceList = absenceList
                absenceAttendanceVC.overallList = overallList
                self.showDetailViewController(absenceAttendanceVC, sender: nil)
                self.navigationController?.pushViewController(absenceAttendanceVC, animated: true)
                
            default:
                print("")
            }
        }
    }
}

    
    
//    @objc
//    func tap(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: self.attendanceCollectionViewOutlet)
//        let indexPath = self.attendanceCollectionViewOutlet.indexPathForItem(at: location)
//        if let index = indexPath {
//            print("Got clicked on index: \(index)!")
//            switch index.item {
//            case 0:
//                print("Present")
//                let insideAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "InsideAttendanceViewControllerID") as! InsideAttendanceViewController
//                insideAttendanceVC.presentationType = .present
//                insideAttendanceVC.overallData = overallList
//                insideAttendanceVC.presentData = presentList
////                insideAttendanceVC.presentData = self.my_datadel_fetch_present
////                insideAttendanceVC.overallData = self.my_data_del_fetch_overall
//                insideAttendanceVC.modalPresentationStyle = .fullScreen
//                self.showDetailViewController(insideAttendanceVC, sender: nil)
//                self.navigationController?.pushViewController(insideAttendanceVC, animated: true)
//            case 1:
//                print("Late")
//                let insideAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "InsideAttendanceViewControllerID") as! InsideAttendanceViewController
//                insideAttendanceVC.presentationType = .late
//                insideAttendanceVC.overallData = overallList
//                insideAttendanceVC.presentData = lateList
//                insideAttendanceVC.modalPresentationStyle = .fullScreen
//                self.showDetailViewController(insideAttendanceVC, sender: nil)
//                self.navigationController?.pushViewController(insideAttendanceVC, animated: true)
//            case 2:
//                print("Total")
//                let totalVC = storyboard?.instantiateViewController(withIdentifier: "TotalAttendanceViewControllerID") as! TotalAttendanceViewController
//                totalVC.modalPresentationStyle = .fullScreen
//                self.showDetailViewController(totalVC, sender: nil)
//                self.navigationController?.pushViewController(totalVC, animated: true)
//            case 3:
//                print("Absence")
//                let insideAttendanceVC = storyboard?.instantiateViewController(withIdentifier: "InsideAttendanceViewControllerID") as! InsideAttendanceViewController
//                insideAttendanceVC.presentationType = .absence
//                insideAttendanceVC.modalPresentationStyle = .fullScreen
//                self.showDetailViewController(insideAttendanceVC, sender: nil)
//                self.navigationController?.pushViewController(insideAttendanceVC, animated: true)
//
//            default:
//                print("")
//            }
//        }
//    }
//}

extension AttendanceViewController : PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
//        let image =
//        get collection view cell -> height, width of View
//        return image.height(forWidth: withWidth)
        if (indexPath.item % 2 == 0) {
            return CGFloat(248)
        }
        else {
            return CGFloat(190)
        }
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
//        let textFont = UIFont(name: "Arial-ItalicMT", size: 11)!
//        return "Some text".heightForWidth(width: withWidth, font: textFont)
        return CGFloat(0)
    }
}


//extension AttendanceViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let width = self.calculateWidth()
////        let width = self.set()
//        if indexPath.item == 0 || indexPath.item == 3 {
//            return CGSize(width: (self.view.frame.width / 2), height: 270)
//        }
//        else {
//            return CGSize(width: (self.view.frame.width / 2), height: 200)
//        }
//    }
//
//    func calculateWidth() -> CGFloat {
//        let estimatedWidth = CGFloat(estimateWidth)
//        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimatedWidth)
//        let margin = CGFloat(cellMarginSize * 2)
//        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / floor(2.0)
//        return width
//    }





    
    
    
    

