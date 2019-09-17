//
//  CategoryDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON

class CategoryDTO: NSObject {
    var ID = "";
    var name = "";
    var thumbnail = "";
    var listSubCat: [CategoryDTO] = [];
    var listProduct: [ProductDTO] = [];
    var listFirstFourProduct: [ProductDTO] = [];
    
    override init() {
        
    }
    
    init(catID: String, name: String, thumb: String) {
        super.init();
        self.ID = catID;
        self.name = name;
        self.thumbnail = thumb;
    }
    
    init(jsonData: JSON) {
        self.ID = jsonData["_id"].stringValue;
        self.name = jsonData["name"].stringValue;
        if (jsonData["subCategories"].array != nil) {
            let subCategories = jsonData["subCategories"].arrayValue;
            for json in subCategories {
                let subCat = CategoryDTO(jsonData: json);
                self.listSubCat.append(subCat);
            }
        }
        if (jsonData["thumbnail"].null == nil) {
             self.thumbnail = jsonData["thumbnail"].stringValue;
        }
    }
}
