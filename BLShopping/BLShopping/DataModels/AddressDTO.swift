//
//  AddressDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddressDTO: NSObject {
    
    var addressID = 0;
    var fullName = "";
    var phone = "";
    var email = "";
    var address = "";
    var isSelected = false;
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        
        if (jsonData["AddressId"].null == nil) {
            self.addressID = jsonData["AddressId"].intValue;
        }
        else if (jsonData["Id"].null == nil) {
            self.addressID = jsonData["Id"].intValue;
        }
        
        var firstName = "";
        if (jsonData["FirstName"].string != nil) {
            firstName = jsonData["FirstName"].stringValue;
        }
        var lastName = "";
        if (jsonData["LastName"].string != nil) {
            lastName = jsonData["LastName"].stringValue;
        }
        self.fullName = firstName + " " + lastName;
        
        if (jsonData["PhoneNumber"].string != nil) {
            self.phone = jsonData["PhoneNumber"].stringValue;
        }
        
        if (jsonData["Email"].string != nil) {
            self.email = jsonData["Email"].stringValue;
        }
        
        if (jsonData["Address1"].string != nil) {
            self.address = jsonData["Address1"].stringValue;
        }
        if (jsonData["StateProvinceName"].string != nil) {
            self.address += ", \(jsonData["StateProvinceName"].stringValue)"
        }
    }
}
