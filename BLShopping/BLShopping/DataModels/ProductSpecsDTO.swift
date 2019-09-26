//
//  ProductSpecsDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProductSpecsDTO: NSObject, NSCoding {
    
    var name = "";
    var value = "";
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        if (jsonData["value"].null == nil) {
            self.value = jsonData["value"].stringValue;
        }
        if (jsonData["spec"].null == nil) {
            let spec = jsonData["spec"]
            self.name = spec["title"].stringValue;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name");
        aCoder.encode(self.value, forKey: "value");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String;
        self.value = aDecoder.decodeObject(forKey: "value") as! String;
    }
    
}
