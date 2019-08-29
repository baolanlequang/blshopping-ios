//
//  FilterVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

protocol FilterVCDelegate {
    func didApplyFilter(listFilters: [FilterDTO]);
}

class FilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    
    var categoryDTO: CategoryDTO?;
    var listFilter: [FilterDTO] = [];
    
    var delegate: FilterVCDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true;
        
        self.btnReset.layer.borderWidth = 1;
        self.btnReset.layer.borderColor = BLColor.sharedInstance.defaultColor().cgColor;
        self.btnReset.setTitleColor(BLColor.sharedInstance.defaultColor(), for: .normal)
        self.btnApply.backgroundColor = BLColor.sharedInstance.highlightButtonColor();
        self.btnApply.setTitleColor(BLColor.sharedInstance.textHighlightButtonColor(), for: .normal)
        
        
        if (self.categoryDTO != nil) {
            if (self.listFilter.count == 0) {
                self.getListFilters();
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //localize strings
        self.lblTitle.text = localizedString(key: "STR_LABEL_SELECT_FILTER")
        self.btnReset.setTitle(localizedString(key: "STR_LABEL_RESET"), for: .normal);
        self.btnApply.setTitle(localizedString(key: "STR_LABEL_APPLY"), for: .normal)
        
        self.tableView.reloadData();
    }
    
    //MARK: - Buttons Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btnApplyClicked(_ sender: Any) {
        self.delegate?.didApplyFilter(listFilters: self.listFilter);
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btnResetClicked(_ sender: Any) {
        for filterDTO in self.listFilter {
            filterDTO.selectedSubFilter = nil;
        }
        self.tableView.reloadData();
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFilter.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell");
            cell?.selectionStyle = .none;
            cell?.accessoryType = .disclosureIndicator;
        }
        let filterDTO = self.listFilter[indexPath.row];
        cell?.textLabel?.text = filterDTO.name;
        if (filterDTO.selectedSubFilter != nil) {
            cell?.detailTextLabel?.text = (filterDTO.selectedSubFilter?.name)!;
        }
        else {
            cell?.detailTextLabel?.text = "";
        }
        return cell!;
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subFilterVC = ListSubFilterVC(nibName: "ListSubFilterVC", bundle: nil);
        let filterDTO = self.listFilter[indexPath.row];
        subFilterVC.filterDTO = filterDTO;
        self.navigationController?.pushViewController(subFilterVC, animated: true);
    }
    
    //MARK: - CALL APIs
    func getListFilters() {
        //TODO: get list filters
        
        //demo
        for i in 1...4 {
            let filter1 = FilterDTO();
            filter1.ID = "\(i)"
            filter1.name = "filter \(i)"
            self.listFilter.append(filter1)
        }
        
        let filter2 = FilterDTO();
        filter2.ID = "123"
        filter2.name = "filter 123"
        self.listFilter[0].listSubFilters.append(filter2)
        self.tableView.reloadData()
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestGetListFilters(categoryID: (self.categoryDTO?.ID)!) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json["LoadFilter2Result"].dictionary != nil) {
//                    let result = json["LoadFilter2Result"];
//                    if (result["SpecificationFilter"].array != nil) {
//                        let arrData = result["SpecificationFilter"].arrayValue;
//                        for jsonData in arrData {
//                            let filterDTO = FilterDTO(jsonData: jsonData)
//                            self.listFilter.append(filterDTO);
//                        }
//                    }
//                    if (result["PriceRangeFilters"].array != nil) {
//                        let filterDTO = FilterDTO();
//                        filterDTO.isFilterPrice = true;
//                        filterDTO.name = "Giá";
//                        let arrData = result["PriceRangeFilters"].arrayValue;
//                        for jsonData in arrData {
//                            let subFilterDTO = FilterDTO(jsonData: jsonData)
//                            subFilterDTO.isFilterPrice = true;
//                            if (subFilterDTO.fromCurrency != "" && subFilterDTO.toCurrency != "") {
//                                subFilterDTO.name = "\(subFilterDTO.fromCurrency) - \(subFilterDTO.toCurrency)"
//                            }
//                            else if (subFilterDTO.fromCurrency == "" && subFilterDTO.toCurrency != "") {
//                                subFilterDTO.name = "Dưới \(subFilterDTO.toCurrency)"
//                            }
//                            else if (subFilterDTO.fromCurrency != "" && subFilterDTO.toCurrency == "") {
//                                subFilterDTO.name = "Từ \(subFilterDTO.fromCurrency)"
//                            }
//                            filterDTO.listSubFilters.append(subFilterDTO);
//                        }
//                        self.listFilter.append(filterDTO);
//                    }
//
//                }
//                self.tableView.reloadData();
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
}
