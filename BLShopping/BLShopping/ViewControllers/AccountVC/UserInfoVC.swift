//
//  UserInfoVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import DLRadioButton
import SwiftyJSON
import MBProgressHUD

class UserInfoVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var radioMale: DLRadioButton!
    @IBOutlet weak var radioFeMale: DLRadioButton!
    @IBOutlet weak var radioChangePass: DLRadioButton!
    @IBOutlet weak var viewChangePass: UIView!
    
    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtReNewPass: UITextField!
    
    @IBOutlet weak var btnShowHideOldPassword: UIButton!
    @IBOutlet weak var btnShowHideNewPassword: UIButton!
    @IBOutlet weak var btnShowHideReNewPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDTO = BLGlobal.shared.userDTO;
        self.txtFullName.text = (userDTO?.name)!;
        self.txtEmail.text = (userDTO?.email)!;
        self.txtPhone.text = (userDTO?.phone)!;
        
        if (userDTO?.gender.lowercased() == "male") {
            self.radioMale.isSelected = true;
        }
        else if (userDTO?.gender.lowercased() == "female") {
            self.radioFeMale.isSelected = true;
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)));
        self.view.addGestureRecognizer(tap);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Show/hide keyboard
    @objc func keyboardWillShow(notification: Notification) -> Void {
        if (self.txtOldPass.isFirstResponder) {
            let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 150);
            self.scrollView.setContentOffset(offset, animated: true);
        }
        if (self.txtNewPass.isFirstResponder) {
            let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 250);
            self.scrollView.setContentOffset(offset, animated: true);
        }
        if (self.txtReNewPass.isFirstResponder) {
            let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 350);
            self.scrollView.setContentOffset(offset, animated: true);
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) -> Void {
        let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 0);
        self.scrollView.setContentOffset(offset, animated: true);
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        let name = self.txtFullName.text;
        let email = self.txtEmail.text;
        let phone = self.txtPhone.text;
        var gender = "";
        if (self.radioMale.isEnabled) {
            gender = "Male";
        }
        else if (self.radioFeMale.isEnabled) {
            gender = "FeMale";
        }
        if (name != "" && email != "") {
            if (isValidEmail(testStr: email!)) {
                if (self.radioChangePass.isSelected) {
                    //need to change password
                    let oldPass = self.txtOldPass.text;
                    let newPass = self.txtNewPass.text;
                    let reNewPass = self.txtReNewPass.text;
                    if (oldPass != "" && newPass != "" && reNewPass != "") {
                        if (newPass == reNewPass) {
                            self.updateUserInfo(fullName: name!, email: email!, phone: phone!, gender: gender);
                        }
                        else {
                            showAlert(title: "", message: "Mật khẩu không khớp", viewController: self);
                        }
                    }
                    else {
                        showAlert(title: "", message: "Vui lòng nhập mật khẩu trước khi tiếp tục", viewController: self);
                    }
                }
                else {
                    self.updateUserInfo(fullName: name!, email: email!, phone: phone!, gender: gender);
                }
            }
            else {
                showAlert(title: "", message: "Email không hợp lệ", viewController: self);
            }
        }
        else {
            showAlert(title: "", message: "Vui lòng nhập tên và email", viewController: self);
        }
    }
    
    @IBAction func radioChangePassClicked(_ sender: Any) {
        
        var viewChangePassFrame = self.viewChangePass.frame;
        if (viewChangePassFrame.size.height > 44) {
            UIView.animate(withDuration: 0.2, animations: {
                viewChangePassFrame.size.height  = 44
                self.viewChangePass.frame = viewChangePassFrame;
            }, completion: { (ifFinished) in
                if (ifFinished) {
                    self.radioChangePass.isSelected = false;
                }
            })
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                viewChangePassFrame.size.height  = 178
                self.viewChangePass.frame = viewChangePassFrame;
            }, completion: { (ifFinished) in
                if (ifFinished) {
                    self.radioChangePass.isSelected = true;
                }
            })
        }
    }
    
    @IBAction func btnDisplayPasswordClicked(_ sender: UIButton) {
        if (sender == self.btnShowHideOldPassword) {
            self.txtOldPass.isSecureTextEntry = !self.txtOldPass.isSecureTextEntry;
            if (self.txtOldPass.isSecureTextEntry) {
                self.btnShowHideOldPassword.setTitle("Hiện", for: .normal);
            }
            else {
                self.btnShowHideOldPassword.setTitle("Ẩn", for: .normal);
            }
        }
        else if (sender == self.btnShowHideNewPassword) {
            self.txtNewPass.isSecureTextEntry = !self.txtNewPass.isSecureTextEntry;
            if (self.txtNewPass.isSecureTextEntry) {
                self.btnShowHideNewPassword.setTitle("Hiện", for: .normal);
            }
            else {
                self.btnShowHideNewPassword.setTitle("Ẩn", for: .normal);
            }
        }
        else if (sender == self.btnShowHideReNewPassword) {
            self.txtReNewPass.isSecureTextEntry = !self.txtReNewPass.isSecureTextEntry;
            if (self.txtReNewPass.isSecureTextEntry) {
                self.btnShowHideReNewPassword.setTitle("Hiện", for: .normal);
            }
            else {
                self.btnShowHideReNewPassword.setTitle("Ẩn", for: .normal);
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    // MARK: - CALL APIs
    func updateUserInfo(fullName: String, email: String, phone: String, gender: String) {
        //TODO: update user info
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO;
//        requestUpdateUserInfo(userID: (userDTO?.userID)!, fullname: fullName, email: email, phone: phone, gender: gender) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("requestUpdateUserInfo: \(responseObject)");
//                let json = JSON(responseObject ?? [:])
//                if (json["InfoEditResult"].string != nil) {
//                    if (json["InfoEditResult"].stringValue == "plugins.xcellenceit.restapi.message.infoedit.success") {
//                        BLGlobal.shared.userDTO?.name = fullName;
//                        BLGlobal.shared.userDTO?.email = email;
//                        BLGlobal.shared.userDTO?.phone = phone;
//                        BLGlobal.shared.userDTO?.gender = gender;
//                        BLGlobal.shared.saveUser();
//
//                        if (self.radioChangePass.isSelected) {
//                            //need to change password
//                            self.changePassword();
//                        }
//                    }
//                    else {
//                        showAlert(title: "", message: json["InfoEditResult"].stringValue, viewController: self);
//                    }
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
    
    func changePassword() {
        //TODO: change password
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let oldPass = self.txtOldPass.text;
//        let newPass = self.txtNewPass.text;
//        let userDTO = BLGlobal.shared.userDTO;
//        requestChangePassword(email: (userDTO?.email)!, oldPassword: oldPass!, newPassword: newPass!) { (operation, reponseObject, error) in
//            hud.hide(animated: true)
//            if (error == nil) {
//                //                print("requestChangePassword: \(reponseObject)");
//                let json = JSON(reponseObject ?? [:]);
//                if (json["ChangePwdResult"].dictionary != nil) {
//                    if (json["ChangePwdResult"]["Message"].string != nil) {
//                        showAlert(title: "", message: json["ChangePwdResult"]["Message"].stringValue, viewController: self);
//                    }
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }

}
