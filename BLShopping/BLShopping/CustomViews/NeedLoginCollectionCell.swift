//
//  NeedLoginCollectionCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol NeedLoginCollectionCellDelegate {
    func openLoginView();
    func openSignUpView();
}

class NeedLoginCollectionCell: UICollectionViewCell {
    
    //variables
    @IBOutlet weak var lblIntro: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    //callback
    var delegate: NeedLoginCollectionCellDelegate?;

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
        self.lblIntro.text = localizedString(key: "STR_LABEL_INTRO_LOGIN")
        self.btnLogin.setTitle(localizedString(key: "STR_LABEL_LOG_IN"), for: .normal)
        self.btnRegister.setTitle(localizedString(key: "STR_LABEL_REGISTER"), for: .normal)
    }

    // MARK: - Buttons Action
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.delegate?.openLoginView();
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        self.delegate?.openSignUpView();
    }
}
