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
    var thumbImageURL = "";
    var imageURL = "";
    var fullSizeImageURL = "";
    
    //TODO: description
//    var listPics: [ProductPictureDTO] = [];
//    var listManufactures: [ManufactureDTO] = [];
//    var listSpecs: [ProductSpecsDTO] = [];
    
    var quantity = 0;
    var itemCartID = "";
    
    override init() {
        
    }
    
    //TODO: init
//    init(jsonData: JSON) {
//        super.init();
//        if (jsonData["ProductId"].null == nil) {
//            self.ID = jsonData["ProductId"].stringValue;
//        }
//        else if (jsonData["Id"].null == nil) {
//            self.ID = jsonData["Id"].stringValue;
//        }
//
//        if (jsonData["Name"].null == nil) {
//            self.name = jsonData["Name"].stringValue;
//        }
//        else if (jsonData["ProductName"].null == nil) {
//            self.name = jsonData["ProductName"].stringValue;
//        }
//
//
//        if (jsonData["ProductPrice"].string != nil) {
//            self.price = jsonData["ProductPrice"].stringValue;
//        }
//        else if (jsonData["ProductPrice"].dictionary != nil) {
//            let dicProductPrice = jsonData["ProductPrice"];
//            if (dicProductPrice["Price"].string != nil) {
//                self.price = dicProductPrice["Price"].stringValue;
//            }
//            if (dicProductPrice["OldPrice"].string != nil) {
//                self.priceBeforeDiscount = dicProductPrice["OldPrice"].stringValue;
//            }
//            if (dicProductPrice["AvailableForPreOrder"].bool != nil) {
//                self.availableForPreOrder = dicProductPrice["AvailableForPreOrder"].boolValue;
//            }
//        }
//        else if (jsonData["UnitPrice"].string != nil) {
//            self.priceBeforeDiscount = jsonData["UnitPrice"].stringValue;
//            if (jsonData["SubTotal"].string != nil) {
//                self.price = jsonData["SubTotal"].stringValue;
//            }
//        }
//
//        if (jsonData["ReviewOverviewModel"].dictionary != nil) {
//            let dicReview = jsonData["ReviewOverviewModel"];
//            if (dicReview["AvailableForPreOrder"].bool != nil) {
//                self.allowCustomerReviews = dicReview["AllowCustomerReviews"].boolValue;
//            }
//            if (dicReview["RatingSum"].double != nil) {
//                self.totalRating = dicReview["RatingSum"].doubleValue;
//            }
//            if (dicReview["TotalReviews"].int != nil) {
//                self.totalReview = dicReview["TotalReviews"].intValue;
//            }
//        }
//        if (jsonData["FullDescription"].string != nil) {
//            self.fullDescription = jsonData["FullDescription"].stringValue;
//        }
//        if (jsonData["ShortDescription"].string != nil) {
//            self.shortDescription = jsonData["ShortDescription"].stringValue;
//        }
//
//        if (jsonData["DefaultPictureModel"].dictionary != nil) {
//            let dicPicture = jsonData["DefaultPictureModel"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//        else if (jsonData["Picture"].dictionary != nil) {
//            let dicPicture = jsonData["Picture"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//
//        if (jsonData["Quantity"].null == nil) {
//            self.quantity = jsonData["Quantity"].intValue;
//        }
//    }
//
//    init(jsonDataCart: JSON) {
//        super.init();
//        if (jsonDataCart["ProductId"].null == nil) {
//            self.ID = jsonDataCart["ProductId"].stringValue;
//        }
//
//        if (jsonDataCart["Id"].null == nil) {
//            self.itemCartID = jsonDataCart["Id"].stringValue;
//        }
//
//        if (jsonDataCart["Name"].null == nil) {
//            self.name = jsonDataCart["Name"].stringValue;
//        }
//        else if (jsonDataCart["ProductName"].null == nil) {
//            self.name = jsonDataCart["ProductName"].stringValue;
//        }
//
//
//        if (jsonDataCart["ProductPrice"].string != nil) {
//            self.price = jsonDataCart["ProductPrice"].stringValue;
//        }
//        else if (jsonDataCart["ProductPrice"].dictionary != nil) {
//            let dicProductPrice = jsonDataCart["ProductPrice"];
//            if (dicProductPrice["Price"].string != nil) {
//                self.price = dicProductPrice["Price"].stringValue;
//            }
//            if (dicProductPrice["OldPrice"].string != nil) {
//                self.priceBeforeDiscount = dicProductPrice["OldPrice"].stringValue;
//            }
//            if (dicProductPrice["AvailableForPreOrder"].bool != nil) {
//                self.availableForPreOrder = dicProductPrice["AvailableForPreOrder"].boolValue;
//            }
//        }
//        else if (jsonDataCart["UnitPrice"].string != nil) {
//            self.priceBeforeDiscount = jsonDataCart["UnitPrice"].stringValue;
//            if (jsonDataCart["SubTotal"].string != nil) {
//                self.price = jsonDataCart["SubTotal"].stringValue;
//            }
//        }
//
//        if (jsonDataCart["ReviewOverviewModel"].dictionary != nil) {
//            let dicReview = jsonDataCart["ReviewOverviewModel"];
//            if (dicReview["AvailableForPreOrder"].bool != nil) {
//                self.allowCustomerReviews = dicReview["AllowCustomerReviews"].boolValue;
//            }
//            if (dicReview["RatingSum"].double != nil) {
//                self.totalRating = dicReview["RatingSum"].doubleValue;
//            }
//            if (dicReview["TotalReviews"].int != nil) {
//                self.totalReview = dicReview["TotalReviews"].intValue;
//            }
//        }
//        if (jsonDataCart["FullDescription"].string != nil) {
//            self.fullDescription = jsonDataCart["FullDescription"].stringValue;
//        }
//        if (jsonDataCart["ShortDescription"].string != nil) {
//            self.shortDescription = jsonDataCart["ShortDescription"].stringValue;
//        }
//
//        if (jsonDataCart["DefaultPictureModel"].dictionary != nil) {
//            let dicPicture = jsonDataCart["DefaultPictureModel"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//        else if (jsonDataCart["Picture"].dictionary != nil) {
//            let dicPicture = jsonDataCart["Picture"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//
//        if (jsonDataCart["Quantity"].null == nil) {
//            self.quantity = jsonDataCart["Quantity"].intValue;
//        }
//    }
//
//    func updateData(jsonData: JSON) {
//        if (jsonData["ProductId"].null == nil) {
//            self.ID = jsonData["ProductId"].stringValue;
//        }
//        else if (jsonData["Id"].null == nil) {
//            self.ID = jsonData["Id"].stringValue;
//        }
//
//        if (jsonData["Name"].null == nil) {
//            self.name = jsonData["Name"].stringValue;
//        }
//        else if (jsonData["ProductName"].null == nil) {
//            self.name = jsonData["ProductName"].stringValue;
//        }
//
//        if (jsonData["ProductPrice"].string != nil) {
//            self.price = jsonData["ProductPrice"].stringValue;
//        }
//        else if (jsonData["ProductPrice"].dictionary != nil) {
//            let dicProductPrice = jsonData["ProductPrice"];
//            if (dicProductPrice["Price"].string != nil) {
//                self.price = dicProductPrice["Price"].stringValue;
//            }
//            if (dicProductPrice["OldPrice"].string != nil) {
//                self.priceBeforeDiscount = dicProductPrice["OldPrice"].stringValue;
//            }
//            if (dicProductPrice["AvailableForPreOrder"].bool != nil) {
//                self.availableForPreOrder = dicProductPrice["AvailableForPreOrder"].boolValue;
//            }
//        }
//
//        if (jsonData["ReviewOverviewModel"].dictionary != nil) {
//            let dicReview = jsonData["ReviewOverviewModel"];
//            if (dicReview["AvailableForPreOrder"].bool != nil) {
//                self.allowCustomerReviews = dicReview["AllowCustomerReviews"].boolValue;
//            }
//            if (dicReview["RatingSum"].double != nil) {
//                self.totalRating = dicReview["RatingSum"].doubleValue;
//            }
//            if (dicReview["TotalReviews"].int != nil) {
//                self.totalReview = dicReview["TotalReviews"].intValue;
//            }
//        }
//        if (jsonData["FullDescription"].string != nil) {
//            self.fullDescription = jsonData["FullDescription"].stringValue;
//        }
//        if (jsonData["ShortDescription"].string != nil) {
//            self.shortDescription = jsonData["ShortDescription"].stringValue;
//        }
//
//        if (jsonData["DefaultPictureModel"].dictionary != nil) {
//            let dicPicture = jsonData["DefaultPictureModel"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//        else if (jsonData["Picture"].dictionary != nil) {
//            let dicPicture = jsonData["Picture"];
//            if (dicPicture["ThumbImageUrl"].string != nil) {
//                self.thumbImageURL = dicPicture["ThumbImageUrl"].stringValue;
//            }
//            if (dicPicture["ImageUrl"].string != nil) {
//                self.imageURL = dicPicture["ImageUrl"].stringValue;
//            }
//            if (dicPicture["FullSizeImageUrl"].string != nil) {
//                self.fullSizeImageURL = dicPicture["FullSizeImageUrl"].stringValue;
//            }
//        }
//
//        if (jsonData["PictureModels"].array != nil) {
//            self.listPics.removeAll();
//            let arrPics = jsonData["PictureModels"].arrayValue;
//            for json in arrPics {
//                let productPicsDTO = ProductPictureDTO(jsonData: json);
//                self.listPics.append(productPicsDTO);
//            }
//        }
//
//        if (jsonData["ProductManufacturers"].array != nil) {
//            self.listManufactures.removeAll();
//            let arrManufacs = jsonData["ProductManufacturers"].arrayValue;
//            for json in arrManufacs {
//                let manufactureDTO = ManufactureDTO(jsonData: json);
//                self.listManufactures.append(manufactureDTO);
//            }
//        }
//
//        if (jsonData["ProductSpecifications"].array != nil) {
//            self.listSpecs.removeAll();
//            let arrSpecs = jsonData["ProductSpecifications"].arrayValue;
//            for json in arrSpecs {
//                let productSpecsDTO = ProductSpecsDTO(jsonData: json);
//                self.listSpecs.append(productSpecsDTO);
//            }
//        }
//
//        if (jsonData["Quantity"].null == nil) {
//            self.quantity = jsonData["Quantity"].intValue;
//        }
//    }
//
    func encode(with aCoder: NSCoder) {
        
        //TODO: encode
//        aCoder.encode(self.ID, forKey: "ID");
//        aCoder.encode(self.name, forKey: "name");
//        aCoder.encode(self.price, forKey: "price");
//        aCoder.encode(self.priceBeforeDiscount, forKey: "priceBeforeDiscount");
//        aCoder.encode(self.availableForPreOrder, forKey: "availableForPreOrder");
//        aCoder.encode(self.allowCustomerReviews, forKey: "allowCustomerReviews");
//        aCoder.encode(self.totalRating, forKey: "totalRating");
//        aCoder.encode(self.totalReview, forKey: "totalReview");
//        aCoder.encode(self.fullDescription, forKey: "fullDescription");
//        aCoder.encode(self.shortDescription, forKey: "shortDescription");
//        aCoder.encode(self.thumbImageURL, forKey: "thumbImageURL");
//        aCoder.encode(self.imageURL, forKey: "imageURL");
//        aCoder.encode(self.fullSizeImageURL, forKey: "fullSizeImageURL");
//
//        var arrDataPics: [Data] = [];
//        for picsDTO in self.listPics {
//            let picData = NSKeyedArchiver.archivedData(withRootObject: picsDTO);
//            arrDataPics.append(picData);
//        }
//        aCoder.encode(arrDataPics, forKey: "listPics");
//        var arrDataManufacture: [Data] = [];
//        for manufactureDTO in self.listManufactures {
//            let manufactureData = NSKeyedArchiver.archivedData(withRootObject: manufactureDTO);
//            arrDataManufacture.append(manufactureData);
//        }
//        aCoder.encode(arrDataManufacture, forKey: "listManufactures");
//        var arrDataSpecs: [Data] = [];
//        for productSpecsDTO in self.listSpecs {
//            let productSpecsData = NSKeyedArchiver.archivedData(withRootObject: productSpecsDTO);
//            arrDataSpecs.append(productSpecsData);
//        }
//        aCoder.encode(arrDataSpecs, forKey: "listSpecs");
    }

    required init?(coder aDecoder: NSCoder) {
        //TODO: decode
//        self.ID = aDecoder.decodeObject(forKey: "ID") as! String;
//        self.name = aDecoder.decodeObject(forKey: "name") as! String;
//        self.price = aDecoder.decodeObject(forKey: "price") as! String;
//        self.priceBeforeDiscount = aDecoder.decodeObject(forKey: "priceBeforeDiscount") as! String;
//        self.availableForPreOrder = aDecoder.decodeBool(forKey: "availableForPreOrder");
//        self.allowCustomerReviews = aDecoder.decodeBool(forKey: "allowCustomerReviews");
//        self.totalRating = aDecoder.decodeDouble(forKey: "totalRating");
//        self.totalReview = aDecoder.decodeInteger(forKey: "totalReview");
//        self.fullDescription = aDecoder.decodeObject(forKey: "fullDescription") as! String;
//        self.shortDescription = aDecoder.decodeObject(forKey: "shortDescription") as! String;
//        self.thumbImageURL = aDecoder.decodeObject(forKey: "thumbImageURL") as! String;
//        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as! String;
//        self.fullSizeImageURL = aDecoder.decodeObject(forKey: "fullSizeImageURL") as! String;
//
//        let arrDataPics = aDecoder.decodeObject(forKey: "listPics") as! [Data];
//        for picsData in arrDataPics {
//            let picsDTO = NSKeyedUnarchiver.unarchiveObject(with: picsData) as! ProductPictureDTO;
//            self.listPics.append(picsDTO)
//        }
//
//        let arrDataManufacture = aDecoder.decodeObject(forKey: "listManufactures") as! [Data];
//        for manufactureData in arrDataManufacture {
//            let manufactureDTO = NSKeyedUnarchiver.unarchiveObject(with: manufactureData) as! ManufactureDTO;
//            self.listManufactures.append(manufactureDTO)
//        }
//
//        let arrDataSpecs = aDecoder.decodeObject(forKey: "listSpecs") as! [Data];
//        for productSpecsData in arrDataSpecs {
//            let productSpecsDTO = NSKeyedUnarchiver.unarchiveObject(with: productSpecsData) as! ProductSpecsDTO;
//            self.listSpecs.append(productSpecsDTO)
//        }
    }
}
