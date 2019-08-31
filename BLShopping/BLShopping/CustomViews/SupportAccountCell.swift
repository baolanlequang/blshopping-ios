//
//  SupportAccountCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol SupportAccountCellDelegate {
    func didClickOpenLogin();
}

class SupportAccountCell: UITableViewCell {
    
    var delegate: SupportAccountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Buttons Action
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.delegate?.didClickOpenLogin();
    }
}
