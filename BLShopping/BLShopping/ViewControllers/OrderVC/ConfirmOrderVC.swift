//
//  ConfirmOrderVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class ConfirmOrderVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listProducts: [ProductDTO] = [];
    var shippingMethod = "";
    var shippingAddress = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getSummaryOrder();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //        self.listProducts = BLGlobal.shared.cartDTO.sortData();
        //        self.tableView.reloadData();
    }
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        self.confirmPayment();
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.listProducts.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: ProductInSummaryCell? = tableView.dequeueReusableCell(withIdentifier: "ProductInSummaryCell") as? ProductInSummaryCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductInSummaryCell", owner: self, options: nil)?.first as? ProductInSummaryCell;
                cell?.selectionStyle = .none;
            }
            
            let productDTO = self.listProducts[indexPath.row];
            cell?.setData(productDTO: productDTO);
            
            return cell!;
        }
        else if (indexPath.section == 1) {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Địa chỉ thanh toán";
                cell?.selectionStyle = .none;
            }
            
            cell?.detailTextLabel?.text = self.shippingAddress;
            
            return cell!;
        }
        else if (indexPath.section == 2) {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Địa chỉ nhận";
                cell?.selectionStyle = .none;
            }
            
            cell?.detailTextLabel?.text = self.shippingAddress;
            
            return cell!;
        }
        else if (indexPath.section == 3) {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Phương thức vận chuyển";
                cell?.selectionStyle = .none;
            }
            
            cell?.detailTextLabel?.text = self.shippingMethod;
            
            return cell!;
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Tổng tiền";
                cell?.selectionStyle = .none;
            }
            var totalAmount = 0.0;
            for productDTO in self.listProducts {
                var price = productDTO.price;
                if (price.contains("₫")) {
                    price = price.replacingOccurrences(of: "₫", with: "");
                    price = price.replacingOccurrences(of: ".", with: "");
                    if (Double(price) != nil) {
                        totalAmount = Double(price)! * Double(productDTO.quantity);
                    }
                }
            }
            
            
            if (totalAmount > 0) {
                let formatter = NumberFormatter()
                formatter.locale = Locale(identifier: "vi_VN");
                formatter.numberStyle = .currency
                if let formattedAmount = formatter.string(from: totalAmount as NSNumber) {
                    cell?.detailTextLabel?.text = "\(formattedAmount)"
                }
            }
            else {
                cell?.detailTextLabel?.text = "Liên hệ nhà cung cấp";
            }
            
            return cell!;
        }
        
    }
    
    // MARK: - CALL APIs
    func getSummaryOrder() {
        //TODO: get summary order
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO;
//        requestSummaryOrder(userID: (userDTO?.userID)!) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json.null == nil) {
//                    print("requestSummaryOrder: \(json)");
//                    let result = json["OrderSummaryResult"];
//                    if (result["Items"].array != nil) {
//                        let items = result["Items"].arrayValue;
//                        for jsonData in items {
//                            let productDTO = ProductDTO(jsonDataCart: jsonData);
//                            self.listProducts.append(productDTO);
//                        }
//                    }
//
//                    if (result["OrderReviewData"].dictionary != nil) {
//                        let overReview = result["OrderReviewData"];
//                        if (overReview["ShippingMethod"].string != nil) {
//                            self.shippingMethod = overReview["ShippingMethod"].stringValue;
//                        }
//                        if (overReview["ShippingAddress"].dictionary != nil) {
//                            let addressDTO = AddressDTO(jsonData: overReview["ShippingAddress"]);
//                            self.shippingAddress = addressDTO.address;
//                        }
//                    }
//
//                    self.tableView.reloadData();
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
    
    
    func confirmPayment() {
        //TODO: confirmpayment
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO;
//        requestConfirmPayment(userID: (userDTO?.userID)!) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                print("requestConfirmPayment: \(responseObject)")
//                let alertView = UIAlertController(title: "Đặt hàng thành công", message: "Cám ơn bạn đã đặt hàng!\n Đơn hàng của bạn đang được xử lý!", preferredStyle: UIAlertControllerStyle.alert)
//                let btnOK = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                    self.navigationController?.popToRootViewController(animated: true);
//                })
//                alertView.addAction(btnOK);
//
//                self.present(alertView, animated: true, completion: nil)
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
    
}
