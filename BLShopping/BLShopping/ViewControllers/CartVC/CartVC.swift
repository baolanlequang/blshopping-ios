//
//  CartVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class CartVC: UIViewController, UITableViewDataSource, UITableViewDelegate, LoginSignupVCDelegate {
    
    // variables
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewEmptyCart: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    var listProducts: [(key: String, value: [ProductDTO])] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.tabBarController?.tabBar.isHidden = true;
        
        // register Notification
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotifications(noti:)), name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: load cart
//        let totalItems = BLGlobal.shared.cartDTO.getTotalProducts();
//        self.lblTitle.text = "Giỏ Hàng (\(totalItems))";
//
//        if (totalItems > 0) {
//            self.viewEmptyCart.isHidden = true;
//
//            let totalAmount = BLGlobal.shared.cartDTO.getTotalAmount();
//            if (totalAmount > 0) {
//                let formatter = NumberFormatter()
//                formatter.locale = Locale(identifier: "vi_VN");
//                formatter.numberStyle = .currency
//                if let formattedAmount = formatter.string(from: totalAmount as NSNumber) {
//                    self.lblTotalAmount.text = "\(formattedAmount)"
//                }
//            }
//            else {
//                self.lblTotalAmount.text = "Liên hệ nhà cung cấp";
//            }
//        }
//        else {
//            self.viewEmptyCart.isHidden = false;
//        }
//
//        self.tabBarController?.tabBar.isHidden = true;
//
//        self.listProducts = BLGlobal.shared.cartDTO.sortData();
//        self.tableView.reloadData();
    }
    
    //MARK: - Receive Notifications
    @objc func receiveNotifications(noti: Notification) -> Void {
        if noti.name == NSNotification.Name(rawValue: NOTI_CART_CHANGED) {
            self.viewWillAppear(false);
        }
    }
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false;
        self.tabBarController?.selectedIndex = 0;
    }
    
    @IBAction func btnOrderClicked(_ sender: Any) {
        if (BLGlobal.shared.userDTO == nil) {
            self.openLoginScreen();
        }
        else {
            self.openOrderScreen()
        }
    }
    
    func openLoginScreen() {
        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
        let nav = UINavigationController(rootViewController: loginVC);
        loginVC.delegate = self;
        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    func openOrderScreen() {
        let orderVC = OrderVC(nibName: "OrderVC", bundle: nil);
        self.navigationController?.pushViewController(orderVC, animated: true);
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.listProducts.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: ProductInfoCartCell? = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCartCell") as? ProductInfoCartCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductInfoCartCell", owner: self, options: nil)?.first as? ProductInfoCartCell;
                //                cell?.delegate = self;
                cell?.selectionStyle = .none;
            }
            let dicData = self.listProducts[indexPath.row];
            cell?.setData(arrProductDTO: dicData.value);
            return cell!;
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell");
                cell?.textLabel?.text = "Tạm tính";
                cell?.selectionStyle = .none;
            }
            //TODO: show total amount
//            let totalAmount = BLGlobal.shared.cartDTO.getTotalAmount();
//            if (totalAmount > 0) {
//                let formatter = NumberFormatter()
//                formatter.locale = Locale(identifier: "vi_VN");
//                formatter.numberStyle = .currency
//                if let formattedAmount = formatter.string(from: totalAmount as NSNumber) {
//                    cell?.detailTextLabel?.text = "\(formattedAmount)"
//                }
//                //                cell?.detailTextLabel?.text = "\(totalAmount)₫";
//            }
//            else {
//                cell?.detailTextLabel?.text = "Liên hệ nhà cung cấp";
//            }
            
            return cell!;
        }
    }
    
    // MARK: - LoginSignupVCDelegate
    func onBackClick() {
        
    }
    
    func onLoginSucceed() {
        self.openOrderScreen();
    }
    
    // MARK: - CALL APIs
    
    
}
