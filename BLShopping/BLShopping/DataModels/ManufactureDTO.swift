//
//  ManufactureDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class ManufactureDTO: NSObject, NSCoding {
    
    var ID = "";
    var name = ""
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        self.ID = jsonData["Id"].stringValue;
        self.name = jsonData["Name"].stringValue;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ID, forKey: "ID");
        aCoder.encode(self.name, forKey: "name");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObject(forKey: "ID") as! String;
        self.name = aDecoder.decodeObject(forKey: "name") as! String;
    }
}
