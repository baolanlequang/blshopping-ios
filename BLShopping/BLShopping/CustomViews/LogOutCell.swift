//
//  LogOutCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol LogOutCellDelegate {
    func onLogOutClicked()
}

class LogOutCell: UITableViewCell {

    @IBOutlet weak var btnLogOut: UIButton!
    
    var delegate: LogOutCellDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: set color
        self.btnLogOut.layer.borderColor = UIColor(hexString: "1BA8FF")?.cgColor ?? UIColor.white.cgColor;
        self.btnLogOut.layer.borderWidth = 1;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        self.delegate?.onLogOutClicked();
    }
}
