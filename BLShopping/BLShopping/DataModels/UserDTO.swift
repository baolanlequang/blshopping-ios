//
//  UserDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserDTO: NSObject, NSCoding {
    var userID = "";
    var email = "";
    var username = "";
    var name = "";
    var gender = "";
    var phone = "";
    
    var isGuest = false;
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        if (jsonData["CustomerId"].string != nil) {
            self.userID = jsonData["CustomerId"].stringValue;
        }
        else if (jsonData["Id"].string != nil) {
            self.userID = jsonData["Id"].stringValue;
        }
        
        if (jsonData["CustomerId"].int != nil) {
            self.userID = "\(jsonData["CustomerId"].intValue)";
        }
        else if (jsonData["Id"].int != nil) {
            self.userID = "\(jsonData["Id"].intValue)";
        }
        
        
        if (jsonData["EmailId"].string != nil) {
            self.email = jsonData["EmailId"].stringValue;
        }
        else if (jsonData["Email"].string != nil) {
            self.email = jsonData["Email"].stringValue;
        }
        
        if (jsonData["UserName"].string != nil) {
            self.username = jsonData["UserName"].stringValue;
        }
        
    }
    
    func updateInfo(jsonData: JSON) {
        if (jsonData["EmailId"].string != nil) {
            self.email = jsonData["EmailId"].stringValue;
        }
        else if (jsonData["Email"].string != nil) {
            self.email = jsonData["Email"].stringValue;
        }
        
        if (jsonData["UserName"].string != nil) {
            self.username = jsonData["UserName"].stringValue;
        }
        
        if (jsonData["FirstName"].string != nil) {
            self.name = jsonData["FirstName"].stringValue;
        }
        
        if (jsonData["Gender"].string != nil) {
            self.gender = jsonData["Gender"].stringValue;
        }
        
        if (jsonData["PhoneNumber"].string != nil) {
            self.phone = jsonData["PhoneNumber"].stringValue;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userID, forKey: "userID");
        aCoder.encode(self.email, forKey: "email");
        aCoder.encode(self.username, forKey: "username");
        aCoder.encode(self.name, forKey: "name");
        aCoder.encode(self.gender, forKey: "gender");
        aCoder.encode(self.phone, forKey: "phone");
        aCoder.encode(self.isGuest, forKey: "isGuest");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userID = aDecoder.decodeObject(forKey: "userID") as! String;
        self.email = aDecoder.decodeObject(forKey: "email") as! String;
        self.username = aDecoder.decodeObject(forKey: "username") as! String;
        self.name = aDecoder.decodeObject(forKey: "name") as! String;
        self.gender = aDecoder.decodeObject(forKey: "gender") as! String;
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String;
        self.isGuest = aDecoder.decodeBool(forKey: "isGuest");
    }
    

}
