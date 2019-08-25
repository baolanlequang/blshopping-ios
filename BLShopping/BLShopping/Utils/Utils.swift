//
//  Utils.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import UIKit

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func getScreenRect() -> CGRect {
    return UIScreen.main.bounds;
}

func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alertView.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil));
    
    viewController.present(alertView, animated: true, completion: nil)
}

func checkIsIpad() -> Bool {
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        return true;
    }
    return false;
}
