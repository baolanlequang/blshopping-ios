//
//  ShippingMethodVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class ShippingMethodVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listShippingMethod: [ShippingMethodDTO] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let methodGround = ShippingMethodDTO(name: "Ground", content: "Compared to other shipping methods, ground shipping is carried out closer to the earth", value: "Ground___Shipping.FixedOrByWeight");
        methodGround.isSelected = true;
        let methodNextDay = ShippingMethodDTO(name: "Next Day Air", content: "The one day air shipping", value: "Next Day Air___Shipping.FixedOrByWeight");
        let methodNextTwoDay = ShippingMethodDTO(name: "2nd Day Air", content: "The two day air shipping", value: "2nd Day Air___Shipping.FixedOrByWeight");
        self.listShippingMethod.append(methodGround);
        self.listShippingMethod.append(methodNextDay);
        self.listShippingMethod.append(methodNextTwoDay);
        self.tableView.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnConfirmShippingClicked(_ sender: Any) {
        for methodDTO in self.listShippingMethod {
            if (methodDTO.isSelected) {
                self.setShippingMethod(methodName: methodDTO.value);
                break;
            }
            
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listShippingMethod.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ShippingMethodCell? = tableView.dequeueReusableCell(withIdentifier: "ShippingMethodCell") as? ShippingMethodCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("ShippingMethodCell", owner: self, options: nil)?.first as? ShippingMethodCell;
            cell?.selectionStyle = .none;
        }
        
        let medthoDTO = self.listShippingMethod[indexPath.row];
        cell?.setData(methodDTO: medthoDTO);
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, methodDTO) in self.listShippingMethod.enumerated() {
            if (index == indexPath.row) {
                methodDTO.isSelected = true;
            }
            else {
                methodDTO.isSelected = false;
            }
        }
        self.tableView.reloadData();
    }
    
    // MARK: - CALL APIs
    func setShippingMethod(methodName: String) {
        //TODO: set shipping method
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestSetShippingMethod(userID: userDTO.userID, methodName: methodName) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                self.setPaymentMethod();
//            }
//        }
    }
    
    func setPaymentMethod() {
        //TODO: set payment method
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!;
//        requestSetPaymentMethod(userID: userDTO.userID, methodName: "Payments.PurchaseOrder") { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                print("setPaymentMethod: \(responseObject)")
//                let json = JSON(responseObject ?? [:]);
//                if (json["SelectPaymentMethodResult"].dictionary != nil) {
//                    if (json["SelectPaymentMethodResult"]["Message"].string != nil) {
//                        let message = json["SelectPaymentMethodResult"]["Message"].stringValue;
//                        if (message.contains("paymentmethodselect")) {
//                            let confirmOrderVC = ConfirmOrderVC(nibName: "ConfirmOrderVC", bundle: nil);
//                            self.navigationController?.pushViewController(confirmOrderVC, animated: true);
//                        }
//                        else {
//                            showAlert(title: "", message: message, viewController: self);
//                        }
//                    }
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
}
