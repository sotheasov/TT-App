//
//  PackageDetailHeaderView.swift
//  TurboTech
//
//  Created by sq on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class PackageDetailHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var dotView: UIView!
    
}

extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
    
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [4,4]
      let cgPath = CGMutablePath()
//    print("Create Dot : ", self.frame.width)
    
    let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
   }
}
