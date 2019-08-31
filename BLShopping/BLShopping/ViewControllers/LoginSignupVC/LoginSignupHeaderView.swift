//
//  LoginSignupHeaderView.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol LoginSignupHeaderViewDelegate {
    func onClickBack();
}

class LoginSignupHeaderView: UIView {
    
    var delegate: LoginSignupHeaderViewDelegate?
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.delegate?.onClickBack();
    }
    
}
