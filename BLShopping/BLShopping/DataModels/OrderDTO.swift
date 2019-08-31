//
//  OrderDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class OrderDTO: NSObject {
    var ID = "";
    var date = "";
    var status = "";
    var total = "";
    var shippingAddress: AddressDTO?;
    var billingAddress: AddressDTO?;
    var paymentMethod = "";
    var paymentStatus = "";
    var shippingStatus = "";
    var shippingMethods = "";
    var tax = "";
    var shippingFee = "";
    var listProducts: [ProductDTO] = [];
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        super.init();
        if (jsonData["OrderId"].null == nil) {
            self.ID = jsonData["OrderId"].stringValue;
        }
        else if (jsonData["Id"].null == nil) {
            self.ID = jsonData["Id"].stringValue;
        }
        if (jsonData["OrderDate"].null == nil) {
            self.date = jsonData["OrderDate"].stringValue;
        }
        if (jsonData["OrderStatus"].null == nil) {
            self.status = jsonData["OrderStatus"].stringValue;
        }
        if (jsonData["OrderTotal"].null == nil) {
            self.total = jsonData["OrderTotal"].stringValue;
        }
        if (jsonData["BillingAddress"].null == nil) {
            self.billingAddress = AddressDTO(jsonData: jsonData["BillingAddress"]);
        }
        if (jsonData["ShippingAddress"].null == nil) {
            self.shippingAddress = AddressDTO(jsonData: jsonData["ShippingAddress"]);
        }
        if (jsonData["PaymentMethods"].null == nil) {
            self.paymentMethod = jsonData["PaymentMethods"].stringValue;
        }
        if (jsonData["PaymentStatus"].null == nil) {
            self.paymentStatus = jsonData["PaymentStatus"].stringValue;
        }
        if (jsonData["ShippingStatus"].null == nil) {
            self.shippingStatus = jsonData["ShippingStatus"].stringValue;
        }
        if (jsonData["ShippingMethods"].null == nil) {
            self.shippingMethods = jsonData["ShippingMethods"].stringValue;
        }
        if (jsonData["Tax"].null == nil) {
            self.tax = jsonData["Tax"].stringValue;
        }
        if (jsonData["OrderShipping"].null == nil) {
            self.shippingFee = jsonData["OrderShipping"].stringValue;
        }
        if (jsonData["OrderItems"].array != nil) {
            let items = jsonData["OrderItems"].arrayValue;
            for jsonProduct in items {
                let productDTO = ProductDTO(jsonDataCart: jsonProduct);
                self.listProducts.append(productDTO);
            }
        }
    }
}
