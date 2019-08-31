//
//  ShippingMethodDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
class ShippingMethodDTO: NSObject {
    var name = "";
    var content = "";
    var value = "";
    var isSelected = false;
    
    override init() {
        
    }
    
    init(name: String, content: String, value: String) {
        super.init();
        self.name = name;
        self.content = content;
        self.value = value;
    }
}
