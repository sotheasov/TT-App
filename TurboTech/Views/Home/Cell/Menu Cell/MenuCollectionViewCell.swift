//
//  MenuCollectionViewCell.swift
//  TurboTech
//
//  Created by sq on 5/20/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Kingfisher

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var menyImageView: UIImageView!
    
    @IBOutlet weak var menuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customCell(menu : Menu){
        self.menuLabel.text = menu.title
        print("Image URL : " + menu.imageUrl)
        let image = UIImage(named: menu.imageUrl)
        let url = URL(string: menu.imageUrl)
        self.menyImageView.kf.setImage(with: url, placeholder: image)
    }

}
