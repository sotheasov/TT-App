//
//  FAQsTableViewCell.swift
//  TurboTech
//
//  Created by sq on 5/26/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit

class FAQsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var answerTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(answer : String){
        answerTextView.text = answer
    }
    
    func setView(){
        containerView.layer.cornerRadius = SIZE.RADIUS
    }
}
