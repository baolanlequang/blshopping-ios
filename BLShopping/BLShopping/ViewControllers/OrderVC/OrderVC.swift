//
//  OrderVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class OrderVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listAddress: [AddressDTO] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getUserAddress();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnConfirmAddressClicked(_ sender: Any) {
        for addressDTO in self.listAddress {
            if (addressDTO.isSelected) {
                self.setBillingAddress(addressDTO: addressDTO);
                break;
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.listAddress.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: ShippingAddressCell? = tableView.dequeueReusableCell(withIdentifier: "ShippingAddressCell") as? ShippingAddressCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ShippingAddressCell", owner: self, options: nil)?.first as? ShippingAddressCell;
                cell?.selectionStyle = .none
            }
            let addressDTO = self.listAddress[indexPath.row];
            cell?.setData(addressDTO: addressDTO);
            return cell!;
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Thêm địa chỉ mới";
                cell?.selectionStyle = .none
            }
            
            return cell!;
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            for (index, addressDTO) in self.listAddress.enumerated() {
                if (index == indexPath.row) {
                    addressDTO.isSelected = true;
                }
                else {
                    addressDTO.isSelected = false;
                }
            }
            self.tableView.reloadData();
            
        }
        else {
            let addNewAddressVC = AddNewAddressVC(nibName: "AddNewAddressVC", bundle: nil);
            self.navigationController?.pushViewController(addNewAddressVC, animated: true);
        }
    }
    
    // MARK: - CALL APIs
    func getUserAddress() {
        //TODO: get user address
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestGetBillingAddress(userID: userDTO.userID) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                print("GetBillingAddressResult: \(String(describing: responseObject))");
//                let json = JSON(responseObject ?? [:]);
//                if (json["GetBillingAddressResult"].dictionary != nil) {
//                    if (json["GetBillingAddressResult"]["ExistingAddresses"].array != nil) {
//                        let arrAddressData = json["GetBillingAddressResult"]["ExistingAddresses"].arrayValue;
//                        for jsonData in arrAddressData {
//                            let addressDTO = AddressDTO(jsonData: jsonData);
//                            self.listAddress.append(addressDTO);
//                        }
//
//                        for (index, addressDTO) in self.listAddress.enumerated() {
//                            if (index == 0) {
//                                addressDTO.isSelected = true;
//                            }
//                            else {
//                                addressDTO.isSelected = false;
//                            }
//                        }
//                    }
//                    self.tableView.reloadData();
//                }
//            }
//
//        }
        
    }
    
    func setBillingAddress(addressDTO: AddressDTO) {
        //TODO: get billing address
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestSetBillingAddress(userID: userDTO.userID, addressID: addressDTO.addressID) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                self.setShippingAddress(addressDTO: addressDTO);
//            }
//        }
    }
    
    func setShippingAddress(addressDTO: AddressDTO) {
        //TODO: get shipping address
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestSetShippingAddress(userID: userDTO.userID, addressID: addressDTO.addressID) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let shippingMethodVC = ShippingMethodVC(nibName: "ShippingMethodVC", bundle: nil);
//                self.navigationController?.pushViewController(shippingMethodVC, animated: true);
//            }
//        }
    }
    
}
