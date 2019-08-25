//
//  BLGlobal.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation

class BLGlobal {

    var userDTO: UserDTO?;
    var cartDTO: CartDTO!;
    
    var currentLanguage = BLLanguageCode.EN;
    
    static let shared = BLGlobal();
    private init() {
        self.userDTO = nil;
        self.cartDTO = CartDTO();
    }
    
    func saveUser() {
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "userDTO");
        if (self.userDTO != nil) {
            let userData = NSKeyedArchiver.archivedData(withRootObject: self.userDTO ?? Data())
            userDefaults.set(userData, forKey: "userDTO");
        }
        userDefaults.synchronize();
    }
    
    func getUser() -> UserDTO? {
        let userDefaults = UserDefaults.standard;
        let userData = userDefaults.data(forKey: "userDTO");
        if (userData != nil) {
            self.userDTO = NSKeyedUnarchiver.unarchiveObject(with: userData!) as? UserDTO;
            return self.userDTO;
        }
        return nil;
    }
    
    func saveDeviceID(deviceID: String) {
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "deviceID");
        userDefaults.set(deviceID, forKey: "deviceID");
        userDefaults.synchronize();
    }
    
    func getCurrentDeviceID() -> String {
        let userDefaults = UserDefaults.standard;
        let deviceID = userDefaults.string(forKey: "deviceID");
        if (deviceID != nil) {
            return deviceID!;
        }
        return "";
    }
    
    func saveDeviceToken(deviceToken: String) {
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "deviceToken");
        userDefaults.set(deviceToken, forKey: "deviceToken");
        userDefaults.synchronize();
    }
    
    func getCurrentDeviceToken() -> String {
        let userDefaults = UserDefaults.standard;
        let deviceToken = userDefaults.string(forKey: "deviceToken");
        if (deviceToken != nil) {
            return deviceToken!;
        }
        return "";
    }
    
    func saveRecentOpenProduct(productDTO: ProductDTO) {
        let userDefaults = UserDefaults.standard;
        var listProduct = getRecentOpenProducts();
        var arrData: [Data] = [];
        let arrFilter = listProduct.filter { (currProduct) -> Bool in
            return currProduct.ID == productDTO.ID;
        }
        if (arrFilter.count == 0) {
            listProduct.insert(productDTO, at: 0)
            if (listProduct.count > 15) {
                listProduct.remove(at: listProduct.count-1);
            }
        }
        
        for product in listProduct {
            let productData = NSKeyedArchiver.archivedData(withRootObject: product)
            arrData.append(productData);
        }
        userDefaults.removeObject(forKey: "recentOpenProduct");
        userDefaults.set(arrData, forKey: "recentOpenProduct");
        userDefaults.synchronize();
    }
    
    func getRecentOpenProducts() -> [ProductDTO] {
        let userDefaults = UserDefaults.standard;
        var listProduct: [ProductDTO] = [];
        let arr = userDefaults.array(forKey: "recentOpenProduct");
        if (arr != nil) {
            let arrData: [Data] = arr as! [Data];
            for data in arrData {
                let productDTO: ProductDTO = NSKeyedUnarchiver.unarchiveObject(with: data) as! ProductDTO;
                listProduct.append(productDTO);
            }
        }
        return listProduct;
    }
    
    public func saveCurrentLanguageVer(languageCode: BLLanguageCode, version: String) -> Void {
        let userDefaults = UserDefaults.standard;
        var versionName = languageCode.rawValue;
        versionName += "_language";
        userDefaults.removeObject(forKey: versionName);
        userDefaults.set(version, forKey: versionName);
        userDefaults.synchronize();
    }
    
    public func getCurrentLanguageVer(languageCode: BLLanguageCode) -> String {
        var version = "";
        var versionName = languageCode.rawValue;
        versionName += "_language";
        
        let userDefaults = UserDefaults.standard;
        let strVersion = userDefaults.string(forKey: versionName);
        if (strVersion != nil) {
            version = strVersion!;
        }
        return version;
    }
    
    public func saveCurrentLanguage(language: BLLanguageCode) -> Void {
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "language");
        userDefaults.set(language.rawValue, forKey: "language");
        userDefaults.synchronize();
    }
    
    public func getCurrentLanguage() -> BLLanguageCode {
        let userDefaults = UserDefaults.standard;
        let language = userDefaults.string(forKey: "language") ?? "en";
        return BLLanguageCode(rawValue: language) ?? .EN;
    }
}
