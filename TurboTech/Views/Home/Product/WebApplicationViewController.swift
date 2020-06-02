//
//  WebApplicationViewController.swift
//  TurboTech
//
//  Created by sq on 5/25/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class WebApplicationViewController: UIViewController {

    @IBOutlet weak var webImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var sumbitButton: UIButton!
    private weak var software : SoftwareSolution?
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setSoftware(software : SoftwareSolution){
        self.software = software
    }
    
    private func setupView(){
        self.navigationItem.title = software?.nameEn ?? ""
        self.sumbitButton.setTitle("Submit", for: .normal)
    }
    
    private func setData(){
        let url = URL(string: software!.imageWebUrl)
//        print(software!.imageWebUrl)
        self.webImageView.kf.setImage(with: url)
        nameLabel.text = software!.nameEn
        detailTextView.text = software!.detailEn
    }
}
