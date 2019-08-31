//
//  AccountVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class AccountVC: UIViewController, LoginSignupVCDelegate, UITableViewDataSource, UITableViewDelegate, LogOutCellDelegate, SupportVCDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.edgesForExtendedLayout = [];
        
        self.getUserInfo();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if (BLGlobal.shared.userDTO == nil || BLGlobal.shared.userDTO?.isGuest == true) {
            self.openSupportPage();
        }
        else {
            self.tableView.reloadData();
        }
        
    }
    
    func openSupportPage() {
        let supportVC = SupportVC(nibName: "SupportVC", bundle: nil);
        supportVC.delegate = self;
        self.navigationController?.pushViewController(supportVC, animated: false);
    }
    
    
    // MARK: - LoginSignupVCDelegate
    func onBackClick() {
        self.tabBarController?.selectedIndex = 0;
    }
    
    func onLoginSucceed() {
        self.getUserInfo();
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: AccountInfoCell? = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell") as? AccountInfoCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("AccountInfoCell", owner: self, options: nil)?.first as? AccountInfoCell;
                cell?.selectionStyle = .none;
                cell?.accessoryType = .disclosureIndicator
            }
            return cell!;
        }
        else if (indexPath.section == 2) {
            var cell: LogOutCell? = tableView.dequeueReusableCell(withIdentifier: "LogOutCell") as? LogOutCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("LogOutCell", owner: self, options: nil)?.first as? LogOutCell;
                cell?.selectionStyle = .none;
            }
            cell?.delegate = self;
            return cell!;
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell");
                cell?.selectionStyle = .none;
                cell?.accessoryType = .disclosureIndicator
            }
            if (indexPath.section == 1) {
                cell?.textLabel?.text = "Quản lý đơn hàng";
            }
            
            return cell!;
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if (indexPath.row == 0) {
                let userInfoVC = UserInfoVC(nibName: "UserInfoVC", bundle: nil);
                self.navigationController?.pushViewController(userInfoVC, animated: true);
            }
            break;
        case 1:
            let listOrderVC = ListOrderVC(nibName: "ListOrderVC", bundle: nil);
            self.navigationController?.pushViewController(listOrderVC, animated: true);
            break;
        default:
            break;
        }
    }
    
    // MARK: - LogOutCellDelegate
    func onLogOutClicked() {
        //TODO: logout clicked
//        BLGlobal.shared.cartDTO.listProduct = [:];
//        BLGlobal.shared.cartDTO.saveCart();
//        BLGlobal.shared.userDTO = nil;
//        BLGlobal.shared.saveUser();
//        self.onBackClick();
    }
    
    // MARK: - CALL APIs
    func getUserInfo() {
        let userDTO = BLGlobal.shared.userDTO;
        if (userDTO != nil && userDTO?.isGuest == false) {
            //TODO: get user info
//            requestGetUserInfo(userID: (userDTO?.userID)!, completion: { (operation, responseObject, error) in
//                if (error == nil) {
//                    //                    print("requestGetUserInfo: \(responseObject)")
//                    let json = JSON(responseObject ?? [:]);
//                    if (json["InfoResult"].dictionary != nil) {
//                        BLGlobal.shared.userDTO?.updateInfo(jsonData: json["InfoResult"])
//                        BLGlobal.shared.saveUser();
//                    }
//                    self.tableView.reloadData();
//                }
//            })
        }
    }

}
