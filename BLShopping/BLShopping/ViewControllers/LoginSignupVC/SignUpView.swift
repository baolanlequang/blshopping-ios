//
//  SignUpView.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import DLRadioButton

protocol SignUpViewDelegate {
    func didBtnRegisterClicked(fullName: String, email: String, password: String);
}

class SignUpView: UIView, UITextFieldDelegate {
    
    // variables
    @IBOutlet weak var txtName: RaisePlaceholder!
    @IBOutlet weak var txtEmail: RaisePlaceholder!
    @IBOutlet weak var txtPassword: RaisePlaceholder!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    var delegate: SignUpViewDelegate?;
    
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
    
    @IBAction func btnRegisterClicked(_ sender: Any) {
        let name = self.txtName.text;
        let email = self.txtEmail.text;
        let password = self.txtPassword.text;
        if (email != "" && password != "" && name != "") {
            if (!isValidEmail(testStr: email!)) {
                self.lblEmailError.text = "Email không đúng";
            }
            else {
                // do sign up
                self.delegate?.didBtnRegisterClicked(fullName: name!, email: email!, password: password!);
            }
        }
        else {
            self.lblNameError.text = "Vui lòng nhập họ tên"
            self.lblEmailError.text = "Vui lòng nhập email";
            self.lblPasswordError.text = "Vui lòng nhập mật khẩu";
            if (email != "" && !isValidEmail(testStr: email!)) {
                self.lblEmailError.text = "Email không đúng";
            }
            self.lblNameError.isHidden = false;
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
            let name = self.txtName.text;
            let email = self.txtEmail.text;
            let password = self.txtPassword.text;
            if (email != "" && password != "" && name != "") {
                if (!isValidEmail(testStr: email!)) {
                    self.lblEmailError.text = "Email không đúng";
                }
                else {
                    // do sign up
                    self.delegate?.didBtnRegisterClicked(fullName: name!, email: email!, password: password!);
                }
            }
            else {
                self.lblNameError.text = "Vui lòng nhập họ tên"
                self.lblEmailError.text = "Vui lòng nhập email";
                self.lblPasswordError.text = "Vui lòng nhập mật khẩu";
                if (email != "" && !isValidEmail(testStr: email!)) {
                    self.lblEmailError.text = "Email không đúng";
                }
                self.lblNameError.isHidden = false;
                self.lblEmailError.isHidden = false;
                self.lblPasswordError.isHidden = false;
            }
        }
        return textField.resignFirstResponder();
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == self.txtName) {
            self.lblNameError.isHidden = true;
        }
        if (textField == self.txtEmail) {
            self.lblEmailError.isHidden = true;
        }
        if (textField == self.txtPassword) {
            self.lblPasswordError.isHidden = true;
        }
        return true;
    }

}
