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
    
    public func defaultColor() -> UIColor {
        return UIColor.init(hexString: "#2699FB")!;
    }
    
    
}
