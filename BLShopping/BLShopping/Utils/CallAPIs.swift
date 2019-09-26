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

//MARK: - Authorization
/**
 Call api sign up with POST request
 @param fullName
 @param email
 @param password
 @return:
 */
func requestSignup(fullName: String, email: String, password: String, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["fullName":fullName, "email":email, "password":password]
    
    manager.post(API_SIGN_UP, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestSignup: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestSignup error: \(error)\n")
        completion(operation, nil, error);
    });
}

/**
 Call api sign up with POST request
 @param email
 @param password
 @return:
 */
func requestLogin(email: String, password: String, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["email":email, "password":password]
    
    manager.post(API_LOGIN, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestLogin: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestLogin error: \(error)\n")
        completion(operation, nil, error);
    });
}

/**
 Call api login by facebook with POST request
 @param facebookID
 @param fullName [OPTIONAL]
 @param email [OPTIONAL]
 @param avatar [OPTIONAL]
 @return:
 */
func requestLoginByFacebook(facebookID: String, fullName: String, email: String, avatar: String, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["facebookID":facebookID, "fullName":fullName, "email":email, "picture":avatar]
    
    manager.post(API_LOGIN_BY_FACEBOOK, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestLoginByFacebook: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestLoginByFacebook error: \(error)\n")
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

//MARK: - Product
/**
 Call api list new added products with GET request
 @return:
 */
func requestNewAddedProducts(completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    manager.get(API_LIST_NEW_ADDED_PRODUCTS, parameters: nil, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestNewAddedProducts: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestNewAddedProducts error: \(error)\n")
        completion(operation, nil, error);
    });
}

/**
 Call api list products with POST request
 @param catID: id of category
 @param page
 @param pageSize
 @param sortType
 @return:
 */
func requestListProducts(catID: String, page: Int, pageSize: Int, sortType: Int, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["catID":catID, "page":page, "pageSize":pageSize, "sortType":sortType] as [String : Any]
    
    manager.post(API_LIST_PRODUCTS, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestListProducts: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestListProducts error: \(error)\n")
        completion(operation, nil, error);
    });
}

/**
 Call api product detail with POST request
 @param productID: id of product
 @return:
 */
func requestProductDetails(productID: String, completion: @escaping (_ operation: URLSessionDataTask?, _ responseObject: Any?, _ error: Error?) -> Void) -> Void {
    let manager = AFHTTPSessionManager();
    manager.requestSerializer = AFJSONRequestSerializer();
    manager.responseSerializer = AFJSONResponseSerializer();
    
    let params = ["id":productID]
    
    manager.post(API_PRODUCT_DETAILS, parameters: params, progress: nil, success: {(operation: URLSessionDataTask, responseObject) in
        //        print("requestProductDetails: \(responseObject)")
        completion(operation, responseObject, nil);
    }, failure: {(operation, error) in
        print("requestProductDetails error: \(error)\n")
        completion(operation, nil, error);
    });
}
