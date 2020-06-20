//
//  ReportAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/15/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Charts
import LGButton
class ReportAttendanceViewController: UIViewController, ChartViewDelegate {

    

    @IBOutlet weak var lbHeaderReportAttendanceOutlet: UILabel!
    @IBOutlet weak var btnBackReportAttendanceOutlet: UIButton!
    
    @IBOutlet weak var btnAbsenceReportOutlet: LGButton!
    @IBOutlet weak var btnPresentReportOutlet: LGButton!
    @IBOutlet weak var btnLateReportOutlet: LGButton!
    @IBOutlet weak var pieChartViewOutlet: PieChartView!

    var pieChart = PieChartView()
    var dataEntries: [ChartDataEntry] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self
        
        let attendance = ["Present", "Absent", "Late"]
        let totalPoint = [168.0, 89.0, 32.0]
        setChart(dataPoints: attendance, values: totalPoint)
        customReportAttendanceViewController()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
    for i in 0..<dataPoints.count {
        
        let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry1)
    }
//    print(dataEntries[0].data)
    let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Total Point")
        
    let pieChartData = PieChartData(dataSet: pieChartDataSet)
    pieChartViewOutlet.data = pieChartData
    pieChartViewOutlet.animate(yAxisDuration: 1.5)

    var colors: [UIColor] = []

    for _ in 0..<dataPoints.count {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
    }

    pieChartDataSet.colors = colors
        
    }

    func customReportAttendanceViewController(){
        lbHeaderReportAttendanceOutlet.textColor = COLOR.COLOR_PRESENT
        btnBackReportAttendanceOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 3), opacity: 0.8)
        
        btnLateReportOutlet.titleString = "Late Staff Report"
        btnLateReportOutlet.titleColor = COLOR.COLOR_LATE
        btnLateReportOutlet.borderColor = COLOR.COLOR_LATE
        btnLateReportOutlet.titleFontSize = SIZE.FONT_SIZE_BUTTON_SMALL
        btnLateReportOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 1), opacity: 0.8)
        
        btnPresentReportOutlet.titleString = "Early Staff Report"
        btnPresentReportOutlet.titleColor = COLOR.COLOR_PRESENT
        btnPresentReportOutlet.borderColor = COLOR.COLOR_PRESENT
        btnPresentReportOutlet.titleFontSize = SIZE.FONT_SIZE_BUTTON_SMALL
        btnPresentReportOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 1), opacity: 0.8)
        
        btnAbsenceReportOutlet.titleString = "Absent Staff Report"
        btnAbsenceReportOutlet.titleColor = COLOR.COLOR_ABSENCE
        btnAbsenceReportOutlet.borderColor = COLOR.COLOR_ABSENCE
        btnAbsenceReportOutlet.titleFontSize = SIZE.FONT_SIZE_BUTTON_SMALL
        btnAbsenceReportOutlet.shadowStyle(radius: 3, color: .black, offset: CGSize(width: -0.5, height: 1), opacity: 0.8)
    }
    
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
//        pieChart.center = view.center
//        view.addSubview(pieChart)
//
//        var dataEntries: [ChartDataEntry] = []
//
//        for i in 0..<10 {
//            dataEntries.append(ChartDataEntry(x: Double(i), y: Double(i)))
//    }
//        let set = PieChartDataSet(dataEntries)
//        set.colors = ChartColorTemplates.colorful()
//        let data = PieChartData(dataSet: set)
//        pieChart.data = data
//    }


    @IBAction func btnBackReportAttendance(_ sender: UIButton) {
        sender.pulsate()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnLateReport(_ sender: LGButton) {
        let lateReportVC = storyboard?.instantiateViewController(withIdentifier: "TotalReportAttendanceViewControllerID") as! TotalReportAttendanceViewController
        lateReportVC.modalPresentationStyle = .fullScreen
        
        self.showDetailViewController(lateReportVC, sender: nil)
        self.navigationController?.pushViewController(lateReportVC, animated: true)
    }
    @IBAction func btnPresentReport(_ sender: LGButton) {
        let lateReportVC = storyboard?.instantiateViewController(withIdentifier: "TotalReportAttendanceViewControllerID") as! TotalReportAttendanceViewController
        lateReportVC.modalPresentationStyle = .fullScreen
        
        self.showDetailViewController(lateReportVC, sender: nil)
        self.navigationController?.pushViewController(lateReportVC, animated: true)
    }
    @IBAction func btnAbsenceReport(_ sender: LGButton) {
        let lateReportVC = storyboard?.instantiateViewController(withIdentifier: "TotalReportAttendanceViewControllerID") as! TotalReportAttendanceViewController
        lateReportVC.modalPresentationStyle = .fullScreen
        
        self.showDetailViewController(lateReportVC, sender: nil)
        self.navigationController?.pushViewController(lateReportVC, animated: true)
    }
    
}








