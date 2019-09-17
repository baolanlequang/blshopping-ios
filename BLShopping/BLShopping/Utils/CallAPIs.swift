//
//  CallAPIs.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import Foundation
import AFNetworking

//MARK: - Banner
/**
 Call api list banner with GET request
 @return:
 */
func requestListBanners(completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    manager.get(API_LIST_BANNERS, parameters: nil, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestListBanners: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestListBanners error: \(error)\n")
        completion(operation, nil, error);
    });
}

//MARK: - Category
/**
 Call api list main categories with GET request
 @return:
 */
func requestMainCategories(completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    manager.get(API_LIST_CATEGORIES, parameters: nil, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestMainCategories: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestMainCategories error: \(error)\n")
        completion(operation, nil, error);
    });
}

/**
 Call api get first four product of category with POST request
 @param catID: id of category
 @return:
 */
func requestFirstFourProduct(catID: String, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["id":catID]
    
    manager.post(API_FIRST_FOUR_PRODUCTS, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestFirstFourProduct: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestFirstFourProduct error: \(error)\n")
        completion(operation, nil, error);
    });
}
