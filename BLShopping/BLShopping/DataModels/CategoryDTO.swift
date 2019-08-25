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
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        self.ID = jsonData["Id"].stringValue;
        self.name = jsonData["Name"].stringValue;
        if (jsonData["SubCategories"].array != nil) {
            let subCategories = jsonData["SubCategories"].arrayValue;
            for json in subCategories {
                let subCat = CategoryDTO(jsonData: json);
                self.listSubCat.append(subCat);
            }
        }
        if (jsonData["PictureModel"].dictionary != nil) {
            if (jsonData["PictureModel"]["ImageUrl"].string != nil) {
                self.thumbnail = jsonData["PictureModel"]["ImageUrl"].stringValue;
            }
        }
    }
}
