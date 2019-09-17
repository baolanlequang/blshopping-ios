//
//  ListStoreVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class ListStoreVC: UIViewController, UITableViewDataSource, UIScrollViewDelegate, ListCategoryCellDelegate, NeedLoginCellDelegate, NewAddedProductCellDelegate, CategoryCellDelegate, LoginSignupVCDelegate {
    
    // variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bgSearchBar: UIView!
    @IBOutlet weak var btnOpenSearch: UIButton!
    
    @IBOutlet weak var marginTopTopBarView: NSLayoutConstraint!
    
    //check scroll
    var lastContentOffset: CGFloat = 0;
    var isDragging = false;
    
    //data
    var listBanners: [BannerDTO] = [];
    var listCategory: [CategoryDTO] = [];
    var listBestSellerProduct: [ProductDTO] = [];
    var listWatchedProduct: [ProductDTO] = [];
    var listNewAddedProduct: [ProductDTO] = [];
    var listHotProduct: [ProductDTO] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true;
        self.edgesForExtendedLayout = [];
        
        //set corner radius
        self.bgSearchBar.layer.cornerRadius = 3;
        
        //set color
        self.topBarView.backgroundColor = BLColor.sharedInstance.defaultColor();
        self.btnOpenSearch.setTitleColor(BLColor.sharedInstance.textHintColor(), for: .normal);
        
        //get data
        self.getSlideBanner();
        self.getCategory();
        self.getBestSellerProduct();
        self.getNewAddedProducts();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: localized and load list viewed product
        self.btnOpenSearch.setTitle(localizedString(key: "STR_LABEL_SEARCH_HINT"), for: .normal);
        
//        self.listWatchedProduct.removeAll();
//        self.listWatchedProduct = BLGlobal.shared.getRecentOpenProducts();
        self.tableView.reloadData();
    }

    // MARK: - Buttons Action
    @IBAction func btnOpenSearchClicked(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1;
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 7) {
            return self.listCategory.count;
        }
        else if (section == 3) {
            if (self.listBestSellerProduct.count > 0) {
                return 1;
            }
            return 0;
        }
        else if (section == 4) {
            if (self.listNewAddedProduct.count > 0) {
                return 1;
            }
            return 0;
        }
        else if (section == 5) {
            if (self.listHotProduct.count > 0) {
                return 1;
            }
            return 0;
        }
        else if (section == 6) {
            if (self.listWatchedProduct.count > 0) {
                return 1;
            }
            return 0;
        }
        else if (section == 2) {
            if (BLGlobal.shared.userDTO != nil) {
                return 0;
            }
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: BannerCell? = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as? BannerCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("BannerCell", owner: self, options: nil)?.first as? BannerCell;
            }
            cell?.setData(listBanner: self.listBanners);
            return cell!;
        }
        else if (indexPath.section == 1) {
            var cell: ListCategoryCell? = tableView.dequeueReusableCell(withIdentifier: "ListCategoryCell") as? ListCategoryCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ListCategoryCell", owner: self, options: nil)?.first as? ListCategoryCell;
            }
            cell?.delegate = self;
            cell?.setData(listCategory: self.listCategory);
            return cell!;
        }
        else if (indexPath.section == 2) {
            var cell: NeedLoginCell? = tableView.dequeueReusableCell(withIdentifier: "NeedLoginCell") as? NeedLoginCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("NeedLoginCell", owner: self, options: nil)?.first as? NeedLoginCell;
            }
            cell?.delegate = self;
            return cell!;
        }
        else if (indexPath.section < 7) {
            var cell: NewAddedProductCell? = tableView.dequeueReusableCell(withIdentifier: "NewAddedProductCell") as? NewAddedProductCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("NewAddedProductCell", owner: self, options: nil)?.first as? NewAddedProductCell;
            }
            cell?.delegate = self;
            
            if (indexPath.section == 3) {
                cell?.setData(listProducts: self.self.listBestSellerProduct);
                cell?.lblTitle.text = localizedString(key: "STR_LABEL_BEST_SELLER_PRODUCT");
            }
            else if (indexPath.section == 4) {
                cell?.setData(listProducts: self.listNewAddedProduct);
                cell?.lblTitle.text = localizedString(key: "STR_LABEL_NEW_PRODUCTS");
            }
            else if (indexPath.section == 5) {
                cell?.setData(listProducts: self.listHotProduct);
                cell?.lblTitle.text = localizedString(key: "STR_LABEL_HOT_PRODUCTS");
            }
            else {
                cell?.setData(listProducts: self.listWatchedProduct);
                cell?.lblTitle.text = localizedString(key: "STR_LABEL_WATCHED_PRODUCTS");
            }
            return cell!;
        }
        else {
            var cell: CategoryCell? = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("CategoryCell", owner: self, options: nil)?.first as? CategoryCell;
            }
            cell?.delegate = self;
            let catDTO = self.listCategory[indexPath.row];
            cell?.setData(catDTO: catDTO);
            return cell!;
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.isDragging) {
            self.marginTopTopBarView.constant -= self.lastContentOffset;
            if (checkIsIpad()) {
                if (self.marginTopTopBarView.constant < -100) {
                    self.marginTopTopBarView.constant = -100;
                }
            }
            else {
                if (self.marginTopTopBarView.constant < -55) {
                    self.marginTopTopBarView.constant = -55;
                }
                else if (self.marginTopTopBarView.constant > 0){
                    self.marginTopTopBarView.constant = 0;
                }
            }
        }
        
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false;
    }
    
    // MARK: - ListCategoryCellDelegate
    func openSeeAllCategory() {
        let listAllCategoriesVC = ListAllCategoriesVC(nibName: "ListAllCategoriesVC", bundle: nil);
        listAllCategoriesVC.listCategory = self.listCategory;
        self.tabBarController?.navigationController?.pushViewController(listAllCategoriesVC, animated: true);
    }
    
    func openCategoryDetail(categoryDTO: CategoryDTO) {
        if (categoryDTO.listSubCat.count > 0) {
            let listAllCategoriesVC = ListAllCategoriesVC(nibName: "ListAllCategoriesVC", bundle: nil);
            listAllCategoriesVC.parentCategory = categoryDTO;
            listAllCategoriesVC.listCategory = categoryDTO.listSubCat;
            self.tabBarController?.navigationController?.pushViewController(listAllCategoriesVC, animated: true);
        }
        else {
            let listProductVC = ListProductVC(nibName: "ListProductVC", bundle: nil);
            listProductVC.categoryDTO = categoryDTO;
            self.tabBarController?.navigationController?.pushViewController(listProductVC, animated: true);
        }
    }
    
    // MARK: - NeedLoginCellDelegate
    func openSignUpView() {
        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
        let nav = UINavigationController(rootViewController: loginVC);
        loginVC.delegate = self;
        loginVC.isShowSignUp = true
        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    func openLoginView() {
        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
        let nav = UINavigationController(rootViewController: loginVC);
        loginVC.delegate = self;
        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    // MARK: - NewAddedProductCellDelegate
    func openProductDetail(productDTO: ProductDTO) {
        let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
        productDetailVC.productDTO = productDTO;
        self.navigationController?.pushViewController(productDetailVC, animated: true);
    }
    
    // MARK: - CategoryCellDelegate
    func openSeeMoreCategory(catDTO: CategoryDTO) {
        let listProductVC = ListProductVC(nibName: "ListProductVC", bundle: nil);
        listProductVC.categoryDTO = catDTO;
        self.tabBarController?.navigationController?.pushViewController(listProductVC, animated: true);
    }
    
    // MARK: - LoginSignupVCDelegate
    func onBackClick() {
        
    }
    
    func onLoginSucceed() {
        self.tableView.reloadData();
    }
    
    // MARK: - CALL APIs
    func getSlideBanner() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        requestListBanners { (operation, responseObject, error) in
            hud.hide(animated: true);
            if (error == nil) {
                let json = JSON(responseObject ?? [:])
                let status = json["status"]
                if (status["code"].intValue == 1) {
                    let data = json["data"].arrayValue;
                    for jsonData in data {
                        let bannerDTO = BannerDTO(jsonData: jsonData);
                        self.listBanners.append(bannerDTO);
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func getCategory() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        requestMainCategories { (operation, responseObject, error) in
            hud.hide(animated: true);
            if (error == nil) {
//                print("requestGetCategory: \(responseObject)");
                let json = JSON(responseObject ?? [:]);
                let status = json["status"]
                if (status["code"] == 1) {
                    let data = json["data"].arrayValue;
                    for jsonData in data {
                        let catDTO = CategoryDTO(jsonData: jsonData);
                        self.listCategory.append(catDTO);
                    }
                    
                    for catDTO in self.listCategory {
                        self.getFirstFourProduct(category: catDTO)
                    }
                    self.tableView.reloadData()
                }
                else {
                    showAlert(title: "", message: status["msg"].stringValue, viewController: self)
                }
            }
            else {

            }
        }
    }
    
    func getBestSellerProduct() {
        //TODO: demo best seller
        for i in 1...5 {
            let product = ProductDTO()
            product.ID = "\(i)"
            product.imageURL = "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg";
            product.name = "Product \(i+1)"
            product.price = "\(i*100)$"
            product.priceBeforeDiscount = "\(i*100+i)$"
            self.listBestSellerProduct.append(product)
        }
        self.tableView.reloadData();
        
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestBestSellerProducts { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("requestBestSellerProducts: \(responseObject)");
//                let json = JSON(responseObject ?? [:]);
//                if (json["BestSellersResult"].dictionary != nil) {
//                    let json = JSON(responseObject ?? [:]);
//                    if (json["BestSellersResult"].array != nil) {
//                        for jsonData in json["BestSellersResult"].arrayValue {
//                            let product = ProductDTO(jsonData: jsonData);
//                            self.listBestSellerProduct.append(product);
//                        }
//                        self.tableView.reloadData();
//                    }
//                    self.tableView.reloadData();
//                }
//                
//            }
//            else {
//                
//            }
//        }
    }
    
    func getNewAddedProducts() {
        //TODO: demo best seller
        for i in 1...5 {
            let product = ProductDTO()
            product.ID = "\(i)"
            product.imageURL = "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg";
            product.name = "Product \(i+1)"
            product.price = "\(i*100)$"
            product.priceBeforeDiscount = "\(i*100+i)$"
            self.listNewAddedProduct.append(product)
        }
        self.tableView.reloadData();
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestGetNewAddedProducts { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("RecentlyAddedProductsResult: \(responseObject)");
//                let json = JSON(responseObject ?? [:]);
//                if (json["RecentlyAddedProductsResult"].array != nil) {
//                    let data = json["RecentlyAddedProductsResult"].arrayValue;
//                    for jsonData in data {
//                        let productDTO = ProductDTO(jsonData: jsonData);
//                        self.listNewAddedProduct.append(productDTO);
//                    }
//                    self.tableView.reloadData();
//                }
//
//            }
//            else {
//
//            }
//        }
    }
    
    func getFirstFourProduct(category: CategoryDTO) {
        requestFirstFourProduct(catID: category.ID) { (operation, responseObject, error) in
            if (error == nil) {
                let json = JSON(responseObject ?? [:]);
                print("getFirstFourProduct: \(json)")
                let status = json["status"];
                if (status["code"].intValue == 1) {
                    let products = json["data"]["products"].arrayValue;
                    for jsonData in products {
                        let productDTO = ProductDTO(jsonData: jsonData);
                        category.listFirstFourProduct.append(productDTO);
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}
