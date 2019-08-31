//
//  ListProductManuVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class ListProductManuVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnChangeDisplay: UIButton!
    
    var tableRefreshControl: UIRefreshControl!;
    var collectionRefreshControl: UIRefreshControl!;
    
    var manufactureDTO: ManufactureDTO?;
    
    let PAGE_SIZE = 10;
    var pageNumber = 0;
    var sortType = 0;
    
    var listProducts: [ProductDTO] = [];
    
    var canLoadMore = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableRefreshControl = UIRefreshControl();
        self.tableRefreshControl.addTarget(self, action: #selector(self.getProduct), for: .valueChanged);
        self.tableView.bottomRefreshControl = self.tableRefreshControl;
        
        self.collectionRefreshControl = UIRefreshControl();
        self.collectionRefreshControl.addTarget(self, action: #selector(self.getProduct), for: .valueChanged);
        self.collectionView.bottomRefreshControl = self.collectionRefreshControl;
        
        self.collectionView.register(UINib(nibName: "ListProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ListProductCollectionCell");
        self.collectionView.register(UINib(nibName: "NeedLoginCollectionCell", bundle: nil), forCellWithReuseIdentifier: "NeedLoginCollectionCell");
        
        if (self.manufactureDTO != nil) {
            self.lblTitle.text = manufactureDTO?.name;
            
            self.getProduct();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listProducts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ListProductCell? = tableView.dequeueReusableCell(withIdentifier: "ListProductCell") as? ListProductCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("ListProductCell", owner: self, options: nil)?.first as? ListProductCell;
            cell?.selectionStyle = .none
        }
        let productDTO = self.listProducts[indexPath.row];
        cell?.setData(productDTO: productDTO);
        return cell!;
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
        let productDTO = self.listProducts[indexPath.row];
        productDetailVC.productDTO = productDTO;
        self.navigationController?.pushViewController(productDetailVC, animated: true);
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listProducts.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ListProductCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "ListProductCollectionCell", for: indexPath) as? ListProductCollectionCell;
        if (cell == nil) {
            if (checkIsIpad()) {
                cell = ListProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 160, height: 300));
            }
            else {
                cell = ListProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 160, height: 220));
            }
        }
        let productDTO = self.listProducts[indexPath.row];
        cell?.setData(productDTO: productDTO);
        return cell!;
        
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (checkIsIpad()) {
            return CGSize(width: collectionView.frame.size.width/2, height: 300);
        }
        return CGSize(width: collectionView.frame.size.width/2, height: 220);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
        let productDTO = self.listProducts[indexPath.row];
        productDetailVC.productDTO = productDTO;
        self.navigationController?.pushViewController(productDetailVC, animated: true);
    }
    
    // MARK: - CALL APIs
    @objc func getProduct() {
        if (self.canLoadMore == false) {
            self.tableRefreshControl.endRefreshing();
            self.collectionRefreshControl.endRefreshing();
            return;
        }
        
        //TODO: get list product
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//
//        let requestPageNumber = self.pageNumber + 1;
//
//        requestGetProductByManufacture(manufactureDTO: self.manufactureDTO!, pageSize: PAGE_SIZE, pageNumber: requestPageNumber) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json["ManufacturerProductResult"].dictionary != nil) {
//                    if (json["ManufacturerProductResult"]["Products"].array != nil) {
//                        let arrProducts = json["ManufacturerProductResult"]["Products"].arrayValue;
//                        for jsonData in arrProducts {
//                            let productDTO = ProductDTO(jsonData: jsonData);
//                            let filterArr = self.listProducts.filter({ (oldProductDTO) -> Bool in
//                                return productDTO.ID == oldProductDTO.ID;
//                            })
//                            if (filterArr.count == 0) {
//                                self.listProducts.append(productDTO);
//                            }
//                        }
//
//                        self.pageNumber = Int(self.listProducts.count/self.PAGE_SIZE);
//
//                        if (requestPageNumber > self.pageNumber) {
//                            self.canLoadMore = false;
//                        }
//                        else {
//                            self.canLoadMore = true;
//                        }
//                    }
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData();
//                        self.collectionView.reloadData();
//                        self.tableRefreshControl.endRefreshing();
//                        self.collectionRefreshControl.endRefreshing();
//                    }
//
//                }
//            }
//        }
    }
}
