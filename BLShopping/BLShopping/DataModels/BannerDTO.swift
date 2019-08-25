//
//  BannerDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation

class BannerDTO: NSObject  {
    var bannerID = "";
    var content = "";
    var imageURL = "";
    var link = "";
    
    override init() {
        
    }
    
    init(bannerID: String, content: String, imageURL: String, link: String) {
        super.init();
        self.bannerID = bannerID;
        self.content = content;
        self.imageURL = imageURL;
        self.link = link;
    }
    
}
