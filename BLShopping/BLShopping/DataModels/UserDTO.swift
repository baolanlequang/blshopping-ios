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
    var facebookID = "";
    var email = "";
    var name = "";
    var phone = "";
    var avatar = ""
    var token = ""
    var refreshToken = ""
    
//    var isGuest = false;
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        self.userID = jsonData["_id"].stringValue;
        if (jsonData["name"].null == nil) {
            self.name = jsonData["name"].stringValue;
        }
        if (jsonData["email"].null == nil) {
            self.email = jsonData["email"].stringValue;
        }
        if (jsonData["phone"].null == nil) {
            self.phone = jsonData["phone"].stringValue;
        }
        if (jsonData["picture"].null == nil) {
            self.avatar = jsonData["picture"].stringValue;
        }
        if (jsonData["token"].null == nil) {
            self.token = jsonData["token"].stringValue;
        }
        if (jsonData["refreshToken"].null == nil) {
            self.refreshToken = jsonData["refreshToken"].stringValue;
        }
        if (jsonData["facebookID"].null == nil) {
            self.facebookID = jsonData["facebookID"].stringValue;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userID, forKey: "userID");
        aCoder.encode(self.email, forKey: "email");
        aCoder.encode(self.name, forKey: "name");
        aCoder.encode(self.phone, forKey: "phone");
        aCoder.encode(self.avatar, forKey: "avatar");
        aCoder.encode(self.token, forKey: "token");
        aCoder.encode(self.refreshToken, forKey: "refreshToken");
        aCoder.encode(self.facebookID, forKey: "facebookID");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userID = aDecoder.decodeObject(forKey: "userID") as! String;
        self.email = aDecoder.decodeObject(forKey: "email") as! String;
        self.name = aDecoder.decodeObject(forKey: "name") as! String;
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String;
        self.avatar = aDecoder.decodeObject(forKey: "avatar") as! String;
        self.token = aDecoder.decodeObject(forKey: "token") as! String;
        self.refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as! String;
        self.facebookID = aDecoder.decodeObject(forKey: "facebookID") as! String;
    }
    

}
