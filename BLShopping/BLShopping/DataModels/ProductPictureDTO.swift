//
//  ProductPictureDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductPictureDTO: NSObject, NSCoding {
    
    var title = "";
    var imageURL = "";
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        if (jsonData["description"].string != nil) {
            self.title = jsonData["description"].stringValue;
        }
        if (jsonData["url"].string != nil) {
            self.imageURL = jsonData["url"].stringValue;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title");
        aCoder.encode(self.imageURL, forKey: "imageURL");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String;
        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as! String;
    }
}
