//
//  SubMenuTableViewCell.swift
//  TurboTech
//
//  Created by sq on 5/21/20.
//  Copyright © 2020 TurboTech. All rights reserved.
//

import UIKit
import Kingfisher

class SubMenuTableViewCell: UITableViewCell {

    // Outlet
    @IBOutlet weak var productLabel : UILabel!
    @IBOutlet weak var productImageView : UIImageView!
    
    @IBOutlet weak var productContainerView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setUpCell(){
        productContainerView.layer.cornerRadius = SIZE.RADIUS
        productLabel.font.withSize(SIZE.FONT_SIZE_CELL_LABEL)
    }
    
    func setData(product : Product){
        let lang = "KH"
        self.tag = product.id
        productLabel.text = "\(lang == "EN" ? product.nameEn : product.nameKh)"
        let url = URL(string: product.imageUrl)
        productImageView.kf.setImage(with: url)
    }
    
    func setData(package : Package){
        let lang = "KH"
        self.tag = package.id
        productLabel.text = "\(lang == "EN" ? package.nameEn : package.nameKh)"
        let url = URL(string: package.imageUrl)
        productImageView.kf.setImage(with: url)
    }
    
}
