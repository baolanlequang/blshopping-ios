//
//  OrderCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(orderDTO: OrderDTO) {
        self.lblOrderID.text = "Mã số đơn hàng: \(orderDTO.ID)";
        self.lblStatus.text = "Tình trạng đơn hàng: \(orderDTO.status)";
        self.lblDate.text = "Ngày đặt hàng: \(orderDTO.date)";
        self.lblTotal.text = "Tổng giá trị đơn hàng: \(orderDTO.total)";
    }
}
