//
//  ReportAttendanceViewController.swift
//  TurboTech
//
//  Created by Sov Sothea on 6/15/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Charts
class ReportAttendanceViewController: UIViewController, ChartViewDelegate {

    

    @IBOutlet weak var pieChartViewOutlet: PieChartView!
    @IBOutlet weak var btnBackReportAttendanceOutlet: UIButton!
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self
        
        let attendance = ["Present", "Absent", "Late"]
        let totalPoint = [168.0, 89.0, 32.0]
        setChart(dataPoints: attendance, values: totalPoint)
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {

    var dataEntries: [ChartDataEntry] = []

    for i in 0..<dataPoints.count {
        let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)

        dataEntries.append(dataEntry1)
    }
//    print(dataEntries[0].data)
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Total Point")
    let pieChartData = PieChartData(dataSet: pieChartDataSet)
    pieChartViewOutlet.data = pieChartData

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
    
}








