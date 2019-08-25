//
//  BLColor.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation

class BLColor {
    static let sharedInstance = BLColor();
    private init() {
        
    } //This prevents others from using the default '()' initializer for this class.
    
    func defaultColor() -> UIColor {
        return UIColor(hexString: "#1BA8FF")!;
    }
    
    func defaultTextColor() -> UIColor {
        return UIColor.black;
    }
    
    func textHintColor() -> UIColor {
        return UIColor(hexString: "#8E8E93")!;
    }
}
