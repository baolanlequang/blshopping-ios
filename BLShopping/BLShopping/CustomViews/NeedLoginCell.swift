//
//  NeedLoginCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol NeedLoginCellDelegate {
    func openLoginView();
    func openSignUpView();
}

class NeedLoginCell: UITableViewCell {

    @IBOutlet weak var lblIntro: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    var delegate: NeedLoginCellDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnRegister.layer.borderWidth = 1;
        
        //set color
        self.lblIntro.textColor = BLColor.sharedInstance.defaultTextColor();
        self.btnLogin.backgroundColor = BLColor.sharedInstance.highlightButtonColor()
        self.btnLogin.setTitleColor(BLColor.sharedInstance.textHighlightButtonColor(), for: .normal)
        self.btnRegister.setTitleColor(BLColor.sharedInstance.defaultColor(), for: .normal)
        self.btnRegister.layer.borderColor = BLColor.sharedInstance.defaultColor().cgColor;
        
        //localize strings
        self.lblIntro.text = localizedString(key: "STR_LABEL_LOG_IN")
        self.btnLogin.setTitle(localizedString(key: "STR_LABEL_LOG_IN"), for: .normal)
        self.btnRegister.setTitle(localizedString(key: "STR_LABEL_REGISTER"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Buttons Action
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.delegate?.openLoginView();
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        self.delegate?.openSignUpView();
    }
    
}
