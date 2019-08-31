//
//  ListOrderVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class ListOrderVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listOrders: [OrderDTO] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getListOrder();
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOrders.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: OrderCell? = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("OrderCell", owner: self, options: nil)?.first as? OrderCell;
        }
        
        let orderDTO = self.listOrders[indexPath.row];
        cell?.setData(orderDTO: orderDTO);
        
        return cell!;
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDTO = self.listOrders[indexPath.row];
        let orderDetailVC = OrderDetailVC(nibName: "OrderDetailVC", bundle: nil);
        orderDetailVC.orderDTO = orderDTO;
        self.navigationController?.pushViewController(orderDetailVC, animated: true);
    }
    
    // MARK: - CALL APIs
    func getListOrder() {
        //TODO: get list order
        
//        let userDTO = BLGlobal.shared.userDTO;
//        if (userDTO != nil) {
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//            requestListOrders(userID: (userDTO?.userID)!, completion: { (operation, resposeObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("getListOrder: \(resposeObject)")
//                    let json = JSON(resposeObject ?? [:]);
//                    if (json["GetOrderResult"].array != nil) {
//                        let result = json["GetOrderResult"].arrayValue;
//                        for jsonData in result {
//                            let orderDTO = OrderDTO(jsonData: jsonData);
//                            self.listOrders.append(orderDTO);
//                        }
//                        self.tableView.reloadData();
//                    }
//                }
//                else {
//                    print(error);
//                }
//            })
//        }
    }

}
