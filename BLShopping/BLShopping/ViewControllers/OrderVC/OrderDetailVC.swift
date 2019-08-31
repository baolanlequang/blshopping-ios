//
//  OrderDetailVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class OrderDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var orderDTO: OrderDTO?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getOrderDetail();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 3) {
            return self.orderDTO!.listProducts.count;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: OrderCell? = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("OrderCell", owner: self, options: nil)?.first as? OrderCell;
            }
            cell?.setData(orderDTO: self.orderDTO!);
            
            return cell!;
        }
        else if (indexPath.section == 1) {
            var cell: OrderPaymentCell? = tableView.dequeueReusableCell(withIdentifier: "OrderPaymentCell") as? OrderPaymentCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("OrderPaymentCell", owner: self, options: nil)?.first as? OrderPaymentCell;
            }
            cell?.setData(orderDTO: self.orderDTO!);
            
            return cell!;
        }
        else if (indexPath.section == 2) {
            var cell: OrderShippingCell? = tableView.dequeueReusableCell(withIdentifier: "OrderShippingCell") as? OrderShippingCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("OrderShippingCell", owner: self, options: nil)?.first as? OrderShippingCell;
            }
            cell?.setData(orderDTO: self.orderDTO!);
            
            return cell!;
        }
        else {
            var cell: ProductInSummaryCell? = tableView.dequeueReusableCell(withIdentifier: "ProductInSummaryCell") as? ProductInSummaryCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductInSummaryCell", owner: self, options: nil)?.first as? ProductInSummaryCell;
            }
            
            let productDTO = self.orderDTO!.listProducts[indexPath.row];
            cell?.setData(productDTO: productDTO);
            
            return cell!;
        }
    }
    
    // MARK: - CALL APIS
    func getOrderDetail() {
        //TODO: get order detail
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        let userDTO = BLGlobal.shared.userDTO!
//        requestGetOrderDetail(userID: userDTO.userID, orderID: (self.orderDTO?.ID)!) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                print(json);
//                if (json["GetOrderDetailResult"].dictionary != nil) {
//                    let result = json["GetOrderDetailResult"];
//                    self.orderDTO = OrderDTO(jsonData: result);
//                    self.tableView.reloadData();
//                }
//            }
//            else {
//                print(error);
//            }
//        }
    }
}
