//
//  SearchVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class SearchVC: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // variables
    @IBOutlet weak var bgSearchBar: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnCancelSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var tableRefreshControl: UIRefreshControl!;
    
    let PAGE_SIZE = 10;
    var pageNumber = 0;
    var sortType = 0;
    
    var listResults: [ProductDTO] = [];
    
    var currSearchString = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.edgesForExtendedLayout = [];
        
        self.bgSearchBar.layer.cornerRadius = 3;
        
        self.tableRefreshControl = UIRefreshControl();
        self.tableRefreshControl.addTarget(self, action: #selector(self.reloadData), for: .valueChanged);
        self.tableView.bottomRefreshControl = self.tableRefreshControl;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reloadData() {
        let searchString = self.txtSearch.text;
        if (searchString == self.currSearchString) {
            self.searchProduct(searchString: searchString!);
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var bgSearchBarFrame = self.bgSearchBar.frame;
        bgSearchBarFrame.size.width = self.view.bounds.size.width - 80;
        self.bgSearchBar.frame = bgSearchBarFrame;
        
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var bgSearchBarFrame = self.bgSearchBar.frame;
        bgSearchBarFrame.size.width = self.view.bounds.size.width - 16;
        self.bgSearchBar.frame = bgSearchBarFrame;
    }
    
    @IBAction func textDidChanged(_ sender: Any) {
        let searchString = self.txtSearch.text;
        self.listResults.removeAll();
        self.tableView.reloadData();
        self.pageNumber = 0;
        if (searchString != "") {
            self.searchProduct(searchString: searchString!);
        }
    }
    
    
    // MARK: - Buttons Action
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.txtSearch.text = "";
        self.txtSearch.resignFirstResponder();
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listResults.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ListProductCell? = tableView.dequeueReusableCell(withIdentifier: "ListProductCell") as? ListProductCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("ListProductCell", owner: self, options: nil)?.first as? ListProductCell;
            cell?.selectionStyle = .none
        }
        let productDTO = self.listResults[indexPath.row];
        cell?.setData(productDTO: productDTO);
        return cell!;
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
        let productDTO = self.listResults[indexPath.row];
        productDetailVC.productDTO = productDTO;
        self.navigationController?.pushViewController(productDetailVC, animated: true);
    }
    
    // MARK: - CALL APIs
    func searchProduct(searchString: String) {
        //TODO: Search product
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//
//        let requestPageNumber = self.pageNumber + 1;
//
//        requestSearchProduct(searchString: searchString, pageSize: PAGE_SIZE, pageNumber: requestPageNumber, sortType: self.sortType) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("requestSearchProduct: \(responseObject)");
//                let json = JSON(responseObject ?? [:]);
//                if (json["SearchProductResult"].dictionary != nil) {
//                    let result = json["SearchProductResult"];
//                    if (result["Products"].array != nil) {
//                        let arrProduct = result["Products"].arrayValue;
//                        for jsonData in arrProduct {
//                            let productDTO = ProductDTO(jsonData: jsonData);
//                            let arrFilter = self.listResults.filter({ (oldProductDTO) -> Bool in
//                                return productDTO.ID == oldProductDTO.ID;
//                            })
//                            if (arrFilter.count == 0) {
//                                self.listResults.append(productDTO);
//                            }
//                        }
//                        self.pageNumber = Int(self.listResults.count/self.PAGE_SIZE);
//                        self.tableView.reloadData();
//                        self.tableRefreshControl.endRefreshing();
//                    }
//                    self.currSearchString = searchString;
//                }
//            }
//            else {
//
//            }
//        }
    }
}
