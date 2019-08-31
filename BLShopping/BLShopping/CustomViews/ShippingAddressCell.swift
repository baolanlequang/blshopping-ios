//
//  ShippingAddressCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ShippingAddressCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(addressDTO: AddressDTO) {
        self.lblName.text = addressDTO.fullName;
        self.lblPhone.text = addressDTO.phone;
        self.lblAddress.text = addressDTO.address;
        
        self.btnCheckBox.isSelected = addressDTO.isSelected;
    }
    
}
