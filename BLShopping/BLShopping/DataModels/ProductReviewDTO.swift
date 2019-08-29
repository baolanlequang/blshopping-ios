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
        self.ID = jsonData["Id"].stringValue;
        if (jsonData["Title"].string != nil) {
            self.title = jsonData["Title"].stringValue;
        }
        if (jsonData["CustomerName"].string != nil) {
            self.customerName = jsonData["CustomerName"].stringValue;
        }
        self.rating = jsonData["Rating"].doubleValue;
        if (jsonData["ReviewText"].string != nil) {
            self.content = jsonData["ReviewText"].stringValue;
        }
        if (jsonData["WrittenOnStr"].string != nil) {
            self.reviewDate = jsonData["WrittenOnStr"].stringValue;
        }
    }
    
}
