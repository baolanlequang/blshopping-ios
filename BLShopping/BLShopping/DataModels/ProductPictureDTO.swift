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
    var thumbImageURL = "";
    var imageURL = "";
    var fullSizeImageURL = "";
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        if (jsonData["Title"].string != nil) {
            self.title = jsonData["Title"].stringValue;
        }
        if (jsonData["ThumbImageUrl"].string != nil) {
            self.thumbImageURL = jsonData["ThumbImageUrl"].stringValue;
        }
        if (jsonData["ImageUrl"].string != nil) {
            self.imageURL = jsonData["ImageUrl"].stringValue;
        }
        if (jsonData["FullSizeImageUrl"].string != nil) {
            self.fullSizeImageURL = jsonData["FullSizeImageUrl"].stringValue;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title");
        aCoder.encode(self.thumbImageURL, forKey: "thumbImageURL");
        aCoder.encode(self.imageURL, forKey: "imageURL");
        aCoder.encode(self.fullSizeImageURL, forKey: "fullSizeImageURL");
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String;
        self.thumbImageURL = aDecoder.decodeObject(forKey: "thumbImageURL") as! String;
        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as! String;
        self.fullSizeImageURL = aDecoder.decodeObject(forKey: "fullSizeImageURL") as! String;
    }
}
