//
//  LoginView.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func didBtnLoginFacebookClicked();
    func didBtnLoginGoogleClicked();
    func didBtnLoginClicked(email: String, password: String);
}

class LoginView: UIView, UITextFieldDelegate {
    
    // variables
    @IBOutlet weak var txtEmail: RaisePlaceholder!
    @IBOutlet weak var txtPassword: RaisePlaceholder!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    var delegate: LoginViewDelegate?;
    
    override func awakeFromNib() {
        self.btnGoogle.layer.borderWidth = 0.5;
        self.btnGoogle.layer.borderColor = UIColor.gray.cgColor;
    }
    
    // MARK: - Buttons Action
    @IBAction func btnDisplayPasswordClicked(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry;
        if (self.txtPassword.isSecureTextEntry) {
            self.btnShowHidePassword.setTitle("Hiện", for: .normal);
        }
        else {
            self.btnShowHidePassword.setTitle("Ẩn", for: .normal);
        }
    }
    
    @IBAction func btnFacebookClicked(_ sender: Any) {
        self.delegate?.didBtnLoginFacebookClicked();
    }
    
    @IBAction func btnGoogleClicked(_ sender: Any) {
        self.delegate?.didBtnLoginGoogleClicked();
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        let email = self.txtEmail.text;
        let password = self.txtPassword.text;
        if (email != "" && password != "") {
            if (!isValidEmail(testStr: email!)) {
                self.lblEmailError.text = "Email không đúng";
            }
            else {
                // do login
                self.delegate?.didBtnLoginClicked(email: email!, password: password!)
            }
        }
        else {
            self.lblEmailError.text = "Vui lòng nhập email";
            self.lblPasswordError.text = "Vui lòng nhập mật khẩu";
            if (email != "" && !isValidEmail(testStr: email!)) {
                self.lblEmailError.text = "Email không đúng";
            }
            self.lblEmailError.isHidden = false;
            self.lblPasswordError.isHidden = false;
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.txtEmail) {
            let email = self.txtEmail.text;
            if (email != "") {
                if (!isValidEmail(testStr: email!)) {
                    self.lblEmailError.text = "Email không đúng";
                    self.lblEmailError.isHidden = false;
                }
            }
        }
        else if (textField == self.txtPassword) {
            let email = self.txtEmail.text;
            let password = self.txtPassword.text;
            if (email != "" && password != "") {
                if (!isValidEmail(testStr: email!)) {
                    self.lblEmailError.text = "Email không đúng";
                }
                else {
                    // do login
                    self.delegate?.didBtnLoginClicked(email: email!, password: password!)
                }
            }
            else {
                self.lblEmailError.text = "Vui lòng nhập email";
                self.lblPasswordError.text = "Vui lòng nhập mật khẩu";
                if (email != "" && !isValidEmail(testStr: email!)) {
                    self.lblEmailError.text = "Email không đúng";
                }
                self.lblEmailError.isHidden = false;
                self.lblPasswordError.isHidden = false;
            }
        }
        return textField.resignFirstResponder();
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == self.txtEmail) {
            self.lblEmailError.isHidden = true;
        }
        if (textField == self.txtPassword) {
            self.lblPasswordError.isHidden = true;
        }
        return true;
    }

}
