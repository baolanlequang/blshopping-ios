//
//  ProductReviewDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductReviewDTO: NSObject {
    
    var ID = "";
    var customerName = "";
    var rating = 0.0;
    var title = "";
    var content = "";
    var reviewDate = ""
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        self.ID = jsonData["_id"].stringValue;
        if (jsonData["title"].null == nil) {
            self.title = jsonData["title"].stringValue;
        }
        if (jsonData["owner"].null != nil) {
            let owner = jsonData["owner"]
            self.customerName = owner["name"].stringValue;
        }
        self.rating = jsonData["rating"].doubleValue;
        if (jsonData["description"].null == nil) {
            self.content = jsonData["description"].stringValue;
        }
        if (jsonData["created"].null == nil) {
            self.reviewDate = jsonData["created"].stringValue;
        }
    }
    
}
