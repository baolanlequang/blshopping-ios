//
//  FilterDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class FilterDTO: NSObject {
    
    var ID = "";
    var name = "";
    var listSubFilters: [FilterDTO] = [];
    var selectedSubFilter: FilterDTO?;
    var isFilterPrice = false;
    var from = "0"
    var to = "0";
    var fromCurrency: String = "";
    var toCurrency: String = "";
    
    override init() {
    }
    
    init(jsonData: JSON) {
        if (jsonData["SpecificationAttributeId"].null == nil) {
            self.ID = jsonData["SpecificationAttributeId"].stringValue;
        }
        else if (jsonData["SpecificationAttributeOptionId"].null == nil) {
            self.ID = jsonData["SpecificationAttributeOptionId"].stringValue;
        }
        
        if (jsonData["SpecificationAttributeName"].null == nil) {
            self.name = jsonData["SpecificationAttributeName"].stringValue;
        }
        else if (jsonData["SpecificationAttributeOptionName"].null == nil) {
            self.name = jsonData["SpecificationAttributeOptionName"].stringValue;
        }
        
        if (jsonData["SpecificationAttributeOptions"].array != nil) {
            let subFilters = jsonData["SpecificationAttributeOptions"].arrayValue;
            for json in subFilters {
                let subDTO = FilterDTO(jsonData: json);
                self.listSubFilters.append(subDTO);
            }
        }
        
        if (jsonData["From"].null == nil) {
            self.from = jsonData["From"].stringValue;
        }
        if (jsonData["To"].null == nil) {
            self.to = jsonData["To"].stringValue;
        }
        if (jsonData["FromCurrency"].null == nil) {
            self.fromCurrency = jsonData["FromCurrency"].stringValue;
        }
        if (jsonData["ToCurrency"].null == nil) {
            self.toCurrency = jsonData["ToCurrency"].stringValue;
        }
    }
    
}
