//
//  CartDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON
import MBProgressHUD

class CartDTO: NSObject {
    
    var ID = "";
    
    var listProduct: [String : [ProductDTO]] = [:];
    
    var isGettingCartFromBackEnd = false;
    
    override init() {
        
    }
    
//    init(jsonData: JSON) {
//        super.init();
//        if (jsonData["Id"].null == nil) {
//            self.ID = jsonData["Id"].stringValue;
//        }
//        if (jsonData["Items"].array != nil) {
//            let arrData = jsonData["Items"].arrayValue;
//            for json in arrData {
//                self.isGettingCartFromBackEnd = true;
//                let productDTO = ProductDTO(jsonDataCart: json);
//                print("id: \(productDTO.ID)")
//                for _ in 0...productDTO.quantity-1 {
//                    self.addProduct(productDTO: productDTO);
//                }
//                
//                //                print("name: \(productDTO.name)")
//            }
//        }
//        //        print("json: \(jsonData)");
//    }
//    
//    func addProduct(productDTO: ProductDTO) {
//        let productID = productDTO.ID;
//        //        print("productID: \(productID)");
//        //        print("productCartID: \(productDTO.itemCartID)");
//        var arrProducts = self.listProduct[productID];
//        if (arrProducts == nil) {
//            arrProducts = [ProductDTO]();
//            
//            arrProducts?.append(productDTO);
//            self.listProduct[productID] = arrProducts;
//            
//            if (self.isGettingCartFromBackEnd == false) {
//                self.addProductToCartOnBackend(productDTO: productDTO);
//            }
//        }
//        else {
//            //            print("ahihih");
//            let firstProductDTO = arrProducts?.first;
//            productDTO.itemCartID = (firstProductDTO?.itemCartID)!
//            arrProducts?.append(productDTO);
//            self.listProduct[productID] = arrProducts;
//            
//            if (BLGlobal.shared.userDTO != nil) {
//                self.updateCartOnBackend();
//            }
//            else {
//                self.addProductToCartOnBackend(productDTO: productDTO);
//            }
//        }
//        
//        self.isGettingCartFromBackEnd = false;
//        
//        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//    }
//    
//    func removeProduct(productID: String) {
//        var removingProductDTO: ProductDTO?;
//        
//        var arrProducts: [ProductDTO]? = self.listProduct[productID];
//        if (arrProducts != nil && (arrProducts?.count)! > 0) {
//            removingProductDTO = arrProducts?.first;
//            arrProducts?.removeLast();
//        }
//        else if (arrProducts == nil) {
//            self.listProduct.removeValue(forKey: productID);
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//            return;
//        }
//        self.listProduct[productID] = arrProducts;
//        
//        if ((arrProducts?.count)! <= 0) {
//            self.listProduct.removeValue(forKey: productID);
//            if (removingProductDTO != nil) {
//                self.removeProductFromCartOnBackend(listProductDTO: [removingProductDTO!])
//            }
//            
//        }
//        else {
//            self.updateCartOnBackend();
//        }
//        
//        
//        
//        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//    }
//    
//    func removeAllProductWithID(productID: String) {
//        var removingProductDTO: ProductDTO?;
//        
//        var arrProducts: [ProductDTO]? = self.listProduct[productID];
//        if (arrProducts != nil && (arrProducts?.count)! > 0) {
//            removingProductDTO = arrProducts?.first;
//            arrProducts?.removeLast();
//        }
//        
//        self.removeProductFromCartOnBackend(listProductDTO: [removingProductDTO!])
//        self.listProduct.removeValue(forKey: productID);
//        
//        //        self.listProduct.removeValue(forKey: productID);
//        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//    }
//    
//    func getTotalProducts() -> Int{
//        var totalItems = 0;
//        let allKeys = self.listProduct.keys;
//        for productID in allKeys {
//            let arrProducts: [ProductDTO]? = self.listProduct[productID];
//            if (arrProducts != nil) {
//                totalItems += (arrProducts?.count)!
//            }
//        }
//        return totalItems;
//    }
//    
//    func getTotalAmount() -> Double {
//        var totalAmount = 0.0;
//        let allKeys = self.listProduct.keys;
//        for productID in allKeys {
//            let arrProducts: [ProductDTO]? = self.listProduct[productID];
//            if (arrProducts != nil) {
//                for productDTO in arrProducts! {
//                    var price = productDTO.price;
//                    if (price.contains("₫")) {
//                        price = price.replacingOccurrences(of: "₫", with: "");
//                        price = price.replacingOccurrences(of: ".", with: "");
//                        if (Double(price) != nil) {
//                            totalAmount += Double(price)!;
//                        }
//                    }
//                }
//            }
//        }
//        return totalAmount;
//    }
//    
//    func sortData() -> [(key: String, value: [ProductDTO])] {
//        let sortedArr = self.listProduct.sorted(by: { $0.0 < $1.0 })
//        return sortedArr;
//    }
//    
//    func saveCart() {
//        if (BLGlobal.shared.userDTO != nil) {
//            let allKeys = self.listProduct.keys;
//            var dicData: [String:[Data]] = [:];
//            for productID in allKeys {
//                let arrProducts: [ProductDTO]? = self.listProduct[productID];
//                if (arrProducts != nil) {
//                    var arrData: [Data] = [];
//                    for productDTO in arrProducts! {
//                        let productData = NSKeyedArchiver.archivedData(withRootObject: productDTO);
//                        arrData.append(productData);
//                    }
//                    dicData[productID] = arrData;
//                }
//            }
//            
//            let userDefaults = UserDefaults.standard;
//            userDefaults.removeObject(forKey: "listProduct");
//            userDefaults.set(dicData, forKey: "listProduct");
//            userDefaults.synchronize();
//        }
//    }
//    
//    func getSavedCart() {
//        let userDefaults = UserDefaults.standard;
//        let listData: [String: [Data]?]? = userDefaults.object(forKey: "listProduct") as? [String : [Data]?];
//        if (listData != nil) {
//            let allKeys = listData?.keys;
//            for productID in allKeys! {
//                let arrData: [Data]? = (listData?[productID])!;
//                if (arrData != nil) {
//                    var arrProduct: [ProductDTO] = [];
//                    for productData in arrData! {
//                        let productDTO = NSKeyedUnarchiver.unarchiveObject(with: productData) as! ProductDTO;
//                        arrProduct.append(productDTO);
//                    }
//                    self.listProduct[productID] = arrProduct;
//                }
//            }
//        }
//    }
//    
//    // MARK: - CALL APIs
//    func updateCartOnBackend() {
//        if (BLGlobal.shared.userDTO != nil) {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestUpdateCartWithMultipleItems(userID: (BLGlobal.shared.userDTO?.userID)!) { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestUpdateCartWithMultipleItems: \(responseObject)")
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                }
//            }
//        }
//        else {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestUpdateCartWithMultipleItems(userID: "") { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestUpdateCartWithMultipleItems: \(responseObject)")
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                }
//            }
//        }
//    }
//    
//    func addProductToCartOnBackend(productDTO: ProductDTO) {
//        if (BLGlobal.shared.userDTO != nil) {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestAddProductToCart(userID: (BLGlobal.shared.userDTO?.userID)!, productID: productDTO.ID, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestAddProductToCart: \(responseObject)")
//                    //                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                    self.getCart(productDTO: productDTO);
//                }
//            })
//        }
//        else {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestAddProductToCart(userID: "", productID: productDTO.ID, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestAddProductToCart: \(responseObject)")
//                    let json = JSON(responseObject ?? [:]);
//                    if (json["DetailAddProductToCartResult"].dictionary != nil) {
//                        let userDTO = UserDTO();
//                        userDTO.userID = json["DetailAddProductToCartResult"]["CustomerId"].stringValue;
//                        userDTO.isGuest = true;
//                        BLGlobal.shared.userDTO = userDTO;
//                        BLGlobal.shared.saveUser();
//                        requestGetShoppingCart(userID: userDTO.userID, completion: { (operation, responseObject2, error) in
//                            if (error == nil) {
//                                //                                print("requestGetShoppingCart: \(responseObject2)")
//                                let json2 = JSON(responseObject2 ?? [:]);
//                                if (json2["CartResult"]["Items"].array != nil) {
//                                    let items = json2["CartResult"]["Items"].arrayValue
//                                    for jsonData in items {
//                                        let tmpProductDTO = ProductDTO(jsonDataCart: jsonData);
//                                        if (tmpProductDTO.ID == productDTO.ID) {
//                                            productDTO.itemCartID = tmpProductDTO.itemCartID;
//                                            productDTO.quantity = tmpProductDTO.quantity;
//                                        }
//                                    }
//                                }
//                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                            }
//                        })
//                    }
//                }
//            })
//        }
//    }
//    
//    func removeProductFromCartOnBackend(listProductDTO: [ProductDTO]) {
//        var strCartItemID = "";
//        for productDTO in listProductDTO {
//            strCartItemID += "\(productDTO.itemCartID),";
//        }
//        if (BLGlobal.shared.userDTO != nil) {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestRemoveProductFromCart(userID: (BLGlobal.shared.userDTO?.userID)!, listCartItemID: strCartItemID, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                }
//            })
//        }
//        else {
//            let appDelegate = UIApplication.shared.delegate;
//            let window = appDelegate?.window;
//            let hud = MBProgressHUD.showAdded(to: window!!, animated: true);
//            requestRemoveProductFromCart(userID: "", listCartItemID: strCartItemID, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                }
//            })
//        }
//    }
//    
//    func getCart(productDTO: ProductDTO) {
//        requestGetShoppingCart(userID: (BLGlobal.shared.userDTO?.userID)!) { (operation, responseObject, error) in
//            if (error == nil) {
//                //                print("getCart: \(responseObject)");
//                let json = JSON(responseObject ?? [:]);
//                if (json["CartResult"].dictionary != nil) {
//                    if (json["CartResult"]["Items"].array != nil) {
//                        let items = json["CartResult"]["Items"].arrayValue;
//                        for jsonData in items {
//                            let tmpProductDTO = ProductDTO(jsonDataCart: jsonData);
//                            if (tmpProductDTO.ID == productDTO.ID) {
//                                productDTO.itemCartID = tmpProductDTO.itemCartID;
//                                productDTO.quantity = tmpProductDTO.quantity
//                            }
//                        }
//                    }
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_CART_CHANGED), object: nil);
//                }
//            }
//            else {
//                
//            }
//        }
//    }
}
