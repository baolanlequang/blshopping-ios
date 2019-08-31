//
//  OrderPaymentCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class OrderPaymentCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(orderDTO: OrderDTO) {
        if (orderDTO.billingAddress != nil) {
            let addressDTO = orderDTO.billingAddress!;
            self.lblName.text = "Tên: \(addressDTO.fullName)";
            self.lblEmail.text = "Email: \(addressDTO.email)";
            self.lblPhone.text = "Điện thoại: \(addressDTO.phone)";
            self.lblAddress.text = "Địa chỉ: \(addressDTO.address)"
        }
        
        self.lblPaymentMethod.text = "Phương thức thanh toán: \(orderDTO.paymentMethod)";
        self.lblPaymentStatus.text = "Trạng thái: \(orderDTO.paymentStatus)";
    }
    
}
