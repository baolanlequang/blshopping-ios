//
//  OrderShippingCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class OrderShippingCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblShippingMethod: UILabel!
    @IBOutlet weak var lblShippingStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(orderDTO: OrderDTO) {
        if (orderDTO.shippingAddress != nil) {
            let addressDTO = orderDTO.shippingAddress!;
            self.lblName.text = "Tên: \(addressDTO.fullName)";
            self.lblEmail.text = "Email: \(addressDTO.email)";
            self.lblPhone.text = "Điện thoại: \(addressDTO.phone)";
            self.lblAddress.text = "Địa chỉ: \(addressDTO.address)"
        }
        
        self.lblShippingMethod.text = "Phương thức vận chuyển: \(orderDTO.shippingMethods)";
        self.lblShippingStatus.text = "Trạng thái vận chuyển: \(orderDTO.shippingStatus)";
    }
    
}
