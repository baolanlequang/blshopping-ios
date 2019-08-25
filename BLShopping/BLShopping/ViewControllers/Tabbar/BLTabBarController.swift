//
//  BLTabBarController.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class BLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false;
        
        //TODO: notification
//        // register Notification
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotifications(noti:)), name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
    }
    
    //MARK: - Receive Notifications
    @objc func receiveNotifications(noti: Notification) -> Void {
        //TODO: handle notification
//        if noti.name == NSNotification.Name(rawValue: NOTI_CART_CHANGED) {
//            self.tabBar.items?[2].badgeValue = "\(BLGlobal.shared.cartDTO.getTotalProducts())"
//        }
    }

}
