//
//  AccountInfoCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class AccountInfoCell: UITableViewCell {
    
    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var lblAvatarName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewAvatar.layer.cornerRadius = 25;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        
        let userDTO = BLGlobal.shared.userDTO;
        if (userDTO != nil && userDTO?.isGuest == false) {
            let range = NSMakeRange(0, 1);
            let name = (userDTO?.name)!
            let userName = (userDTO?.username)!;
            var strName: NSString;
            if (name.count > 0) {
                strName = name as NSString;
            }
            else {
                strName = userName as NSString;
            }
            
            let subStr = strName.substring(with: range);
            self.lblAvatarName.text = subStr.uppercased();
            
            self.lblUserName.text = (userDTO?.name)!
            self.lblEmail.text = (userDTO?.email)!
        }
        
    }
    
}
