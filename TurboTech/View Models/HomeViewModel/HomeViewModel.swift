//
//  HomeViewModel.swift
//  TurboTech
//
//  Created by sq on 6/16/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import Foundation

class HomeViewModel {
    let homeService = HomeService()
    func fetchSliderImage(completion : @escaping(_ imageList : [HomeImage])->()){
        homeService.fetchSliderImage { (images) in
            completion(images)
        }
    }
}
