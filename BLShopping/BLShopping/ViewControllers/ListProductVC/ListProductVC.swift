//
//  ListProductVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/27/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD;

class ListProductVC: UIViewController {
    
    //variables
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnChangeDisplay: UIButton!
    @IBOutlet weak var btnSort: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tableRefreshControl: UIRefreshControl!;
    var collectionRefreshControl: UIRefreshControl!;
    
    //TODO: SelectSortTypeView
//    var selectSortTypeView: SelectSortTypeView!;
    
    //data
    var categoryDTO: CategoryDTO?;
    
    let PAGE_SIZE = 10;
    var pageNumber = 0;
    var sortType = 0;
    var isApplingFilter = false;
    
    var listProducts: [ProductDTO] = [];
    //TODO: filter
//    var currListFilters: [FilterDTO] = [];
    
    var canLoadMore = true;

    override func viewDidLoad() {
        super.viewDidLoad()

        //set color
        self.topView.backgroundColor = BLColor.sharedInstance.defaultColor();
        
        self.tableRefreshControl = UIRefreshControl();
        self.tableRefreshControl.addTarget(self, action: #selector(self.getProduct), for: .valueChanged);
        self.tableView.bottomRefreshControl = self.tableRefreshControl;
        
        self.collectionRefreshControl = UIRefreshControl();
        self.collectionRefreshControl.addTarget(self, action: #selector(self.getProduct), for: .valueChanged);
        self.collectionView.bottomRefreshControl = self.collectionRefreshControl;
        
        self.collectionView.register(UINib(nibName: "ListProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ListProductCollectionCell");
        self.collectionView.register(UINib(nibName: "NeedLoginCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NeedLoginCollectionCell");
        
        if (self.categoryDTO != nil) {
            self.lblTitle.text = categoryDTO?.name;
            
            self.getProduct();
        }
        
        //TODO: SelectSortTypeView
//        self.selectSortTypeView = Bundle.main.loadNibNamed("SelectSortTypeView", owner: self, options: nil)?.first as! SelectSortTypeView
//        self.selectSortTypeView.delegate = self;
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (self.categoryDTO != nil) {
            self.lblTitle.text = categoryDTO?.name;
            
            self.getProduct();
        }
        else {
            self.lblTitle.text = localizedString(key: "STR_LABEL_LIST_PRODUCTS")
        }
        
    }

    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnSortClicked(_ sender: Any) {
        //TODO: SortType
//        let type = SortType(rawValue: self.sortType);
//        self.selectSortTypeView.show(type: type!);
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        //TODO: FilterVC
//        let filterVC = FilterVC(nibName: "FilterVC", bundle: nil);
//        filterVC.delegate = self;
//        let navFilter = UINavigationController(rootViewController: filterVC);
//        filterVC.categoryDTO = self.categoryDTO;
//        filterVC.listFilter = self.currListFilters;
//        self.navigationController?.present(navFilter, animated: true, completion: nil);
    }
    
    @IBAction func btnChangeDisplayClicked(_ sender: Any) {
        if (self.collectionView.isHidden) {
            self.collectionView.isHidden = false;
        }
        else {
            self.collectionView.isHidden = true;
        }
    }
    
    // MARK: - UITableViewDataSource
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2;
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section == 0) {
//            if (BLGlobal.shared.userDTO != nil) {
//                return 0;
//            }
//            return 1;
//        }
//        return self.listProducts.count;
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.section == 0) {
//            var cell: NeedLoginCell? = tableView.dequeueReusableCell(withIdentifier: "NeedLoginCell") as? NeedLoginCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("NeedLoginCell", owner: self, options: nil)?.first as? NeedLoginCell;
//                cell?.selectionStyle = .none
//            }
//            cell?.delegate = self;
//            return cell!;
//        }
//        else if (indexPath.section == 1) {
//            var cell: ListProductCell? = tableView.dequeueReusableCell(withIdentifier: "ListProductCell") as? ListProductCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("ListProductCell", owner: self, options: nil)?.first as? ListProductCell;
//                cell?.selectionStyle = .none
//            }
//            let productDTO = self.listProducts[indexPath.row];
//            cell?.setData(productDTO: productDTO);
//            return cell!;
//        }
//        else {
//            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
//            if (cell == nil) {
//                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
//            }
//            return cell!;
//        }
//    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section > 0) {
            //TODO: ProductDetailVC
//            let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
//            let productDTO = self.listProducts[indexPath.row];
//            productDetailVC.productDTO = productDTO;
//            self.navigationController?.pushViewController(productDetailVC, animated: true);
        }
    }
    
    // MARK: - UICollectionViewDataSource
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2;
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (section == 0) {
//            if (BLGlobal.shared.userDTO != nil) {
//                return 0;
//            }
//            return 1;
//        }
//        return self.listProducts.count;
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if (indexPath.section == 0) {
//            var cell: NeedLoginCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NeedLoginCollectionCell", for: indexPath) as? NeedLoginCollectionCell;
//            if (cell == nil) {
//                cell = NeedLoginCollectionCell(frame: CGRect(x: 0, y: 0, width: 320, height: 100));
//            }
//            cell?.delegate = self;
//            return cell!;
//        }
//        else {
//            var cell: ListProductCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "ListProductCollectionCell", for: indexPath) as? ListProductCollectionCell;
//            if (cell == nil) {
//                if (checkIsIpad()) {
//                    cell = ListProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 160, height: 300));
//                }
//                else {
//                    cell = ListProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 160, height: 220));
//                }
//            }
//            let productDTO = self.listProducts[indexPath.row];
//            cell?.setData(productDTO: productDTO);
//            return cell!;
//        }
//        
//    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0) {
            return CGSize(width: collectionView.frame.size.width, height: 100);
        }
        else if (checkIsIpad()) {
            return CGSize(width: collectionView.frame.size.width/2, height: 300);
        }
        return CGSize(width: collectionView.frame.size.width/2, height: 220);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section > 0) {
            //TODO: ProductDetailVC
//            let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
//            let productDTO = self.listProducts[indexPath.row];
//            productDetailVC.productDTO = productDTO;
//            self.navigationController?.pushViewController(productDetailVC, animated: true);
        }
    }
    
    // MARK: - NeedLoginCellDelegate
    func openSignUpView() {
        //TODO: LoginSignupVC
//        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
//        let nav = UINavigationController(rootViewController: loginVC);
//        loginVC.delegate = self;
//        loginVC.isShowSignUp = true
//        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    func openLoginView() {
        //TODO: LoginSignupVC
//        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
//        let nav = UINavigationController(rootViewController: loginVC);
//        loginVC.delegate = self;
//        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    // MARK: - LoginSignupVCDelegate
    func onBackClick() {
        
    }
    
    func onLoginSucceed() {
        self.tableView.reloadData();
        self.collectionView.reloadData();
    }
    
    // MARK: - SelectSortTypeViewDelegate
    //TODO: SelectSortTypeViewDelegate
//    func onSelectedType(type: SortType) {
//        self.sortType = type.rawValue;
//        self.listProducts.removeAll();
//        self.pageNumber = 0;
//        self.tableView.reloadData();
//        self.collectionView.reloadData();
//        self.getProduct();
//    }
    
    // MARK: - FilterVCDelegate
    //TODO: FilterVCDelegate
//    func didApplyFilter(listFilters: [FilterDTO]) {
//        self.isApplingFilter = false;
//        for filterDTO in listFilters {
//            if (filterDTO.selectedSubFilter != nil) {
//                self.isApplingFilter = true;
//                break;
//            }
//        }
//
//        self.currListFilters = listFilters;
//        self.listProducts.removeAll();
//        self.pageNumber = 0;
//        self.tableView.reloadData();
//        self.collectionView.reloadData();
//
//        self.getProduct();
//
//    }
    
    // MARK: - CALL APIs
    @objc func getProduct() {
        if (self.canLoadMore == false) {
            self.tableRefreshControl.endRefreshing();
            self.collectionRefreshControl.endRefreshing();
            return;
        }
        
        
        //TODO: getProduct
        
//        if (self.categoryDTO != nil) {
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//
//            let requestPageNumber = self.pageNumber + 1;
//
//            if (self.isApplingFilter == false) {
//                requestGetProductByCategory(categoryDTO: self.categoryDTO!, pageSize: PAGE_SIZE, pageNumber: requestPageNumber, sortType: sortType, completion: { (operation, responseObject, error) in
//                    hud.hide(animated: true);
//                    if (error == nil) {
//                        //                        print("requestGetProductByCategory: \(responseObject)");
//                        let json = JSON(responseObject ?? [:]);
//                        if (json["GetProductByCategoryResult"].dictionary != nil) {
//                            if (json["GetProductByCategoryResult"]["Products"].array != nil) {
//                                let arrProducts = json["GetProductByCategoryResult"]["Products"].arrayValue;
//                                if (arrProducts.count > 0) {
//                                    self.canLoadMore = true;
//                                }
//                                else {
//                                    self.canLoadMore = false;
//                                }
//                                for jsonData in arrProducts {
//                                    let productDTO = ProductDTO(jsonData: jsonData);
//                                    let filterArr = self.listProducts.filter({ (oldProductDTO) -> Bool in
//                                        return productDTO.ID == oldProductDTO.ID;
//                                    })
//                                    if (filterArr.count == 0) {
//                                        self.listProducts.append(productDTO);
//                                    }
//                                }
//
//                                self.pageNumber = Int(self.listProducts.count/self.PAGE_SIZE);
//
//                                if (requestPageNumber > self.pageNumber) {
//                                    self.canLoadMore = false;
//                                }
//                                else {
//                                    self.canLoadMore = true;
//                                }
//                            }
//
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData();
//                                self.collectionView.reloadData();
//                                self.tableRefreshControl.endRefreshing();
//                                self.collectionRefreshControl.endRefreshing();
//                            }
//
//                        }
//                    }
//                    else {
//                        print(error)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData();
//                            self.collectionView.reloadData();
//                            self.tableRefreshControl.endRefreshing();
//                            self.collectionRefreshControl.endRefreshing();
//                        }
//                    }
//                })
//            }
//            else {
//                //apply filter
//                requestGetProductByFilter(listFilter: self.currListFilters, categoryDTO: self.categoryDTO!, pageSize: PAGE_SIZE, pageNumber: requestPageNumber, sortType: sortType, completion: { (operation, responseObject, error) in
//                    hud.hide(animated: true);
//                    if (error == nil) {
//                        //                        print("requestGetProductByFilter: \(responseObject)");
//                        let json = JSON(responseObject ?? [:]);
//                        if (json["ApplyFilterResult"].dictionary != nil) {
//                            if (json["ApplyFilterResult"]["Products"].array != nil) {
//                                let arrProducts = json["ApplyFilterResult"]["Products"].arrayValue;
//                                if (arrProducts.count > 0) {
//                                    self.canLoadMore = true;
//                                }
//                                else {
//                                    self.canLoadMore = false;
//                                }
//
//                                for jsonData in arrProducts {
//                                    let productDTO = ProductDTO(jsonData: jsonData);
//                                    let filterArr = self.listProducts.filter({ (oldProductDTO) -> Bool in
//                                        return productDTO.ID == oldProductDTO.ID;
//                                    })
//                                    if (filterArr.count == 0) {
//                                        self.listProducts.append(productDTO);
//                                    }
//
//                                }
//
//                                self.pageNumber = Int(self.listProducts.count/self.PAGE_SIZE);
//
//                                if (requestPageNumber > self.pageNumber) {
//                                    self.canLoadMore = false;
//                                }
//                                else {
//                                    self.canLoadMore = true;
//                                }
//                            }
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData();
//                                self.collectionView.reloadData();
//                                self.tableRefreshControl.endRefreshing();
//                                self.collectionRefreshControl.endRefreshing();
//                            }
//                        }
//                    }
//                    else {
//                        print(error)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData();
//                            self.collectionView.reloadData();
//                            self.tableRefreshControl.endRefreshing();
//                            self.collectionRefreshControl.endRefreshing();
//                        }
//                    }
//                })
//            }
//
//        }
    }
}
