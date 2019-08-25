//
//  Constants.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation

// MARK: - Order status
enum BLLanguageCode: String {
    case EN = "en"
    case VI = "vi"
    init(fromRawValue: String) {
        self = BLLanguageCode(rawValue: fromRawValue) ?? .EN
    }
}
