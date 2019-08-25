//
//  SplashVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;

        //TODO: check user
//        let userDTO = BLGlobal.shared.getUser();
//        if (userDTO != nil) {
//            self.getCart();
//        }
        
        self.gotoMain();
        
    }

    func gotoMain() {
        let listStoreVC = ListStoreVC(nibName: "ListStoreVC", bundle: nil);
        let searchVC = SearchVC(nibName: "SearchVC", bundle: nil);
        let cartVC = CartVC(nibName: "CartVC", bundle: nil);
        let accountVC = AccountVC(nibName: "AccountVC", bundle: nil);
        let notificationVC = NotificationVC(nibName: "NotificationVC", bundle: nil);
        
        let navListStore = BLNavigationController(rootViewController: listStoreVC);
        let navSearch = BLNavigationController(rootViewController: searchVC);
        let navCart = BLNavigationController(rootViewController: cartVC);
        let navAccount = BLNavigationController(rootViewController: accountVC);
        let navNotification = BLNavigationController(rootViewController: notificationVC);
        
        let tabbar = BLTabBarController();
        tabbar.viewControllers = [navListStore, navSearch, navCart, navAccount, navNotification];
        
        navListStore.tabBarItem = UITabBarItem(title: "Cửa Hàng", image: UIImage(named: "icon_home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon_home_selected")?.withRenderingMode(.alwaysOriginal));
        
        navSearch.tabBarItem = UITabBarItem(title: "Tìm Kiếm", image: UIImage(named: "icon_search")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon_search_selected")?.withRenderingMode(.alwaysOriginal));
        
        navCart.tabBarItem = UITabBarItem(title: "Giỏ Hàng", image: UIImage(named: "icon_cart")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon_cart_selected")?.withRenderingMode(.alwaysOriginal));
        
        //TODO: show badgeValue
//        navCart.tabBarItem.badgeValue = "\(BLGlobal.shared.cartDTO.getTotalProducts())";
        
        navAccount.tabBarItem = UITabBarItem(title: "Tài Khoản", image: UIImage(named: "icon_user")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon_user_selected")?.withRenderingMode(.alwaysOriginal));
        
        navNotification.tabBarItem = UITabBarItem(title: "Thông Báo", image: UIImage(named: "icon_notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon_notification_selected")?.withRenderingMode(.alwaysOriginal));
        
        self.navigationController?.pushViewController(tabbar, animated: true);
        
    }
    
    // MARK: - CALL APIs
    func getCart() {
        //TODO: getCart
        
//        requestGetShoppingCart(userID: (BLGlobal.shared.userDTO?.userID)!) { (operation, responseObject, error) in
//            if (error == nil) {
//                print("getCart: \(responseObject)");
//                let json = JSON(responseObject ?? [:]);
//                if (json["CartResult"].dictionary != nil) {
//                    let cartDTO = CartDTO(jsonData: json["CartResult"]);
//                    BLGlobal.shared.cartDTO = cartDTO;
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
}
