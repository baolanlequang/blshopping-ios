//
//  ShippingMethodCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ShippingMethodCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(methodDTO: ShippingMethodDTO) {
        self.lblName.text = methodDTO.name;
        self.lblContent.text = methodDTO.content;
        
        self.btnCheckBox.isSelected = methodDTO.isSelected;
    }
    
}
