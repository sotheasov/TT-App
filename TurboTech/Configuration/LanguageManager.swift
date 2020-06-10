//
//  LanguageManager.swift
//  TurboTech
//
//  Created by sq on 5/28/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation
// let lang = UserDefaults.standard.string(forKey: "LanguageCode")
class LanguageManager {
    static let shared = LanguageManager()
    var language : String {
        get {
            if let lang = UserDefaults.standard.string(forKey: "LanguageCode"){
                return lang
            } else {
                return "km"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "LanguageCode")
        }
    }
}

extension String {

    var localized : String {

        let path = Bundle.main.path(forResource: LanguageManager.shared.language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let translated = (bundle?.localizedString(forKey: self, value: nil, table: nil))!
        return translated

    }

}
