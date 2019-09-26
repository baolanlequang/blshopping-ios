//
//  ProductDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductDTO: NSObject, NSCoding {
    var ID = "";
    var name = "";
    var price = "";
    var priceBeforeDiscount = "";
    var availableForPreOrder = false;
    var allowCustomerReviews = false;
    var totalRating = 0.0;
    var totalReview = 0;
    var fullDescription = "";
    var shortDescription = "";
    var imageURL = "";
    var averageRating = 0.0
    var sku = ""
    
    var listPics: [ProductPictureDTO] = [];
    var listManufactures: [ManufactureDTO] = [];
    var listSpecs: [ProductSpecsDTO] = [];
    
    var quantity = 0;
    var itemCartID = "";
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        super.init();
        if (jsonData["_id"].null == nil) {
            self.ID = jsonData["_id"].stringValue;
        }

        if (jsonData["name"].null == nil) {
            self.name = jsonData["name"].stringValue;
        }

        if (jsonData["price"].null == nil) {
            self.price = jsonData["price"].stringValue;
        }
        
        if (jsonData["priceBeforeDiscount"].null == nil) {
            self.priceBeforeDiscount = jsonData["priceBeforeDiscount"].stringValue;
        }
        
        if (jsonData["allowReview"].null == nil) {
            self.allowCustomerReviews = jsonData["allowReview"].boolValue;
        }
        
        if (jsonData["description"].null == nil) {
            self.fullDescription = jsonData["description"].stringValue;
        }
        if (jsonData["shortDescription"].null == nil) {
            self.shortDescription = jsonData["shortDescription"].stringValue;
        }

        if (jsonData["productImages"].null == nil) {
            let arrImages = jsonData["productImages"].arrayValue;
            for jsonPic in arrImages {
                let picDTO = ProductPictureDTO(jsonData: jsonPic);
                self.listPics.append(picDTO)
            }
            if (self.listPics.count > 0) {
                let firstPic = self.listPics[0]
                self.imageURL = firstPic.imageURL;
            }
        }
        
        if (jsonData["specifications"].null == nil) {
            let arrSpecs = jsonData["specifications"].arrayValue;
            for jsonSpec in arrSpecs {
                let specDTO = ProductSpecsDTO(jsonData: jsonSpec);
                self.listSpecs.append(specDTO)
            }
        }
        if (jsonData["averageRating"].null == nil) {
            self.averageRating = jsonData["averageRating"].doubleValue
        }
        if (jsonData["sku"].null == nil) {
            self.sku = jsonData["sku"].stringValue
        }
    }

    init(jsonDataCart: JSON) {
        super.init();
        if (jsonDataCart["ProductId"].null == nil) {
            self.ID = jsonDataCart["ProductId"].stringValue;
        }

        if (jsonDataCart["Id"].null == nil) {
            self.itemCartID = jsonDataCart["Id"].stringValue;
        }

        if (jsonDataCart["Name"].null == nil) {
            self.name = jsonDataCart["Name"].stringValue;
        }
        else if (jsonDataCart["ProductName"].null == nil) {
            self.name = jsonDataCart["ProductName"].stringValue;
        }


        if (jsonDataCart["ProductPrice"].string != nil) {
            self.price = jsonDataCart["ProductPrice"].stringValue;
        }
        else if (jsonDataCart["ProductPrice"].dictionary != nil) {
            let dicProductPrice = jsonDataCart["ProductPrice"];
            if (dicProductPrice["Price"].string != nil) {
                self.price = dicProductPrice["Price"].stringValue;
            }
            if (dicProductPrice["OldPrice"].string != nil) {
                self.priceBeforeDiscount = dicProductPrice["OldPrice"].stringValue;
            }
            if (dicProductPrice["AvailableForPreOrder"].bool != nil) {
                self.availableForPreOrder = dicProductPrice["AvailableForPreOrder"].boolValue;
            }
        }
        else if (jsonDataCart["UnitPrice"].string != nil) {
            self.priceBeforeDiscount = jsonDataCart["UnitPrice"].stringValue;
            if (jsonDataCart["SubTotal"].string != nil) {
                self.price = jsonDataCart["SubTotal"].stringValue;
            }
        }

        if (jsonDataCart["ReviewOverviewModel"].dictionary != nil) {
            let dicReview = jsonDataCart["ReviewOverviewModel"];
            if (dicReview["AvailableForPreOrder"].bool != nil) {
                self.allowCustomerReviews = dicReview["AllowCustomerReviews"].boolValue;
            }
            if (dicReview["RatingSum"].double != nil) {
                self.totalRating = dicReview["RatingSum"].doubleValue;
            }
            if (dicReview["TotalReviews"].int != nil) {
                self.totalReview = dicReview["TotalReviews"].intValue;
            }
        }
        if (jsonDataCart["FullDescription"].string != nil) {
            self.fullDescription = jsonDataCart["FullDescription"].stringValue;
        }
        if (jsonDataCart["ShortDescription"].string != nil) {
            self.shortDescription = jsonDataCart["ShortDescription"].stringValue;
        }

    

        if (jsonDataCart["Quantity"].null == nil) {
            self.quantity = jsonDataCart["Quantity"].intValue;
        }
    }

    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.ID, forKey: "ID");
        aCoder.encode(self.name, forKey: "name");
        aCoder.encode(self.price, forKey: "price");
        aCoder.encode(self.priceBeforeDiscount, forKey: "priceBeforeDiscount");
        aCoder.encode(self.availableForPreOrder, forKey: "availableForPreOrder");
        aCoder.encode(self.allowCustomerReviews, forKey: "allowCustomerReviews");
        aCoder.encode(self.totalRating, forKey: "totalRating");
        aCoder.encode(self.totalReview, forKey: "totalReview");
        aCoder.encode(self.fullDescription, forKey: "fullDescription");
        aCoder.encode(self.shortDescription, forKey: "shortDescription");
        aCoder.encode(self.imageURL, forKey: "imageURL");

        var arrDataPics: [Data] = [];
        for picsDTO in self.listPics {
            let picData = NSKeyedArchiver.archivedData(withRootObject: picsDTO);
            arrDataPics.append(picData);
        }
        aCoder.encode(arrDataPics, forKey: "listPics");
        var arrDataManufacture: [Data] = [];
        for manufactureDTO in self.listManufactures {
            let manufactureData = NSKeyedArchiver.archivedData(withRootObject: manufactureDTO);
            arrDataManufacture.append(manufactureData);
        }
        aCoder.encode(arrDataManufacture, forKey: "listManufactures");
        var arrDataSpecs: [Data] = [];
        for productSpecsDTO in self.listSpecs {
            let productSpecsData = NSKeyedArchiver.archivedData(withRootObject: productSpecsDTO);
            arrDataSpecs.append(productSpecsData);
        }
        aCoder.encode(arrDataSpecs, forKey: "listSpecs");
    }

    required init?(coder aDecoder: NSCoder) {
        self.ID = aDecoder.decodeObject(forKey: "ID") as! String;
        self.name = aDecoder.decodeObject(forKey: "name") as! String;
        self.price = aDecoder.decodeObject(forKey: "price") as! String;
        self.priceBeforeDiscount = aDecoder.decodeObject(forKey: "priceBeforeDiscount") as! String;
        self.availableForPreOrder = aDecoder.decodeBool(forKey: "availableForPreOrder");
        self.allowCustomerReviews = aDecoder.decodeBool(forKey: "allowCustomerReviews");
        self.totalRating = aDecoder.decodeDouble(forKey: "totalRating");
        self.totalReview = aDecoder.decodeInteger(forKey: "totalReview");
        self.fullDescription = aDecoder.decodeObject(forKey: "fullDescription") as! String;
        self.shortDescription = aDecoder.decodeObject(forKey: "shortDescription") as! String;
        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as! String;

        let arrDataPics = aDecoder.decodeObject(forKey: "listPics") as! [Data];
        for picsData in arrDataPics {
            let picsDTO = NSKeyedUnarchiver.unarchiveObject(with: picsData) as! ProductPictureDTO;
            self.listPics.append(picsDTO)
        }

        let arrDataManufacture = aDecoder.decodeObject(forKey: "listManufactures") as! [Data];
        for manufactureData in arrDataManufacture {
            let manufactureDTO = NSKeyedUnarchiver.unarchiveObject(with: manufactureData) as! ManufactureDTO;
            self.listManufactures.append(manufactureDTO)
        }

        let arrDataSpecs = aDecoder.decodeObject(forKey: "listSpecs") as! [Data];
        for productSpecsData in arrDataSpecs {
            let productSpecsDTO = NSKeyedUnarchiver.unarchiveObject(with: productSpecsData) as! ProductSpecsDTO;
            self.listSpecs.append(productSpecsDTO)
        }
    }
}
