//
//  AddNewAddressVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class AddNewAddressVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        let name = self.txtName.text;
        let phone = self.txtPhone.text;
        let email = self.txtEmail.text;
        let address = self.txtAddress.text;
        
        if (name != "" && phone != "" && email != "" && address != "") {
            self.saveAddress(name: name!, phone: phone!, email: email!, address: address!);
        }
        else {
            showAlert(title: "", message: "Vui lòng nhập đầy đủ thông tin trước khi tiếp tục", viewController: self);
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    // MARK : - CALL APIs
    func saveAddress(name: String, phone: String, email: String, address: String) {
        //TODO: save address
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestAddUserAddress(userID: userDTO.userID, fullname: name, email: email, phone: phone, address: address) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("saveAddress: \(responseObject)")
//                let json = JSON(responseObject ?? [:]);
//                if (json["AddAddressResult"].string != nil) {
//                    if (json["AddAddressResult"].stringValue == "") {
//                        showAlert(title: "", message: "Địa chỉ của bạn đã được lưu", viewController: self);
//                    }
//                    else {
//                        showAlert(title: "", message: json["AddAddressResult"].stringValue, viewController: self);
//                    }
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
}
