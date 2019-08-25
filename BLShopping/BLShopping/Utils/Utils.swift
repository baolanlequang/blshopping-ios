//
//  Utils.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func getScreenRect() -> CGRect {
    return UIScreen.main.bounds;
}

func getVersion() -> String {
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"];
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"];
    
    return "\(version!)_\(buildNumber!)";
}

func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alertView.addAction(UIAlertAction(title: localizedString(key: "STR_LABEL_OK"), style: UIAlertAction.Style.default, handler:nil));
    
    viewController.present(alertView, animated: true, completion: nil)
}

func checkIsIpad() -> Bool {
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        return true;
    }
    return false;
}

func localizedString(key: String) -> String {
    var result = key;
    let userDefaults = UserDefaults.standard;
    
    let savedAppVersion = userDefaults.string(forKey: "savedAppVersion");
    let currentAppVersion = getVersion();
    
    let langugeName = currentAppVersion + "_language_\(BLGlobal.shared.currentLanguage.rawValue)";
    var savedLanguage = userDefaults.dictionary(forKey: langugeName)
    
    if (savedAppVersion != nil && savedAppVersion != currentAppVersion) {
        //remove old language
        let oldEN = savedAppVersion! + "_language_\(BLGlobal.shared.currentLanguage.rawValue)";
        userDefaults.removeObject(forKey: oldEN)
        userDefaults.synchronize();
    }
    
    userDefaults.set(currentAppVersion, forKey: "savedAppVersion");
    
    if (savedLanguage == nil ) {
        var filePath: URL?;
        let fileName = BLGlobal.shared.currentLanguage.rawValue;
        filePath = Bundle.main.url(forResource: fileName, withExtension: "json");
        
        do {
            let data = try Data(contentsOf: filePath!)
            let json = try JSON.init(data: data);
            if (json["version"].null == nil) {
                BLGlobal.shared.saveCurrentLanguageVer(languageCode: BLGlobal.shared.currentLanguage, version: json["version"].stringValue);
                
            }
            
            if (json[key].string != nil) {
                result = (json[key].stringValue);
            }
            savedLanguage = json.dictionaryObject;
            userDefaults.set(savedLanguage, forKey: langugeName);
            userDefaults.synchronize();
        }
        catch {
            //            print("err: \(savedLanguage)");
        }
    }
    else {
        let json = JSON.init(rawValue: savedLanguage ?? [:]);
        if (json?[key].string != nil) {
            result = (json?[key].stringValue)!;
        }
    }
    
    return result;
}
