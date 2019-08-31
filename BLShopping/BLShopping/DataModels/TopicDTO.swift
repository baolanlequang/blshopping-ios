//
//  TopicDTO.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import SwiftyJSON

class TopicDTO: NSObject {
    var ID = "";
    var date = "";
    var name = "";
    
    
    override init() {
        
    }
    
    init(jsonData: JSON) {
        super.init();
        self.ID = jsonData["TopicId"].stringValue;
        self.name = jsonData["SystemName"].stringValue;
    }
}
