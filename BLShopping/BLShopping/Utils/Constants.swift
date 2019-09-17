//
//  Constants.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation

// MARK: - APIs
let SERVER = "http://192.168.0.105:3030/api/";

//api Banner
let API_LIST_BANNERS = SERVER + "banners"

//api Category
let API_LIST_CATEGORIES = SERVER + "category/categories"
let API_FIRST_FOUR_PRODUCTS = SERVER + "category/first_four_products"

//api Product
let API_LIST_NEW_ADDED_PRODUCTS = SERVER + "product/new_added"
let API_LIST_PRODUCTS = SERVER + "product/list_products"


// MARK: - Order status
enum BLLanguageCode: String {
    case EN = "en"
    case VI = "vi"
    init(fromRawValue: String) {
        self = BLLanguageCode(rawValue: fromRawValue) ?? .EN
    }
}

enum SortType: Int {
    case POSITION = 0
    case A_Z = 1
    case Z_A = 2
    case LOW_HIGH = 3
    case HIGH_LOW = 4
    case CREATED_BY = 5
}

let NOTI_CART_CHANGED = "NotiCartChanged"
let NOTI_ADD_REVIEW = "NotiAddReview"
