//
//  String-Extension.swift
//  TurboTech
//
//  Created by sq on 6/13/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

extension String {
    var phoneNumber : String {
        if self.first == "0" {
            return "+855\(self.dropFirst())"
        } else {
            return self
        }
//        return ""
    }
}
