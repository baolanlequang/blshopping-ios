//
//  ListSubFilterVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ListSubFilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var filterDTO: FilterDTO?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.filterDTO != nil) {
            self.lblTitle.text = (self.filterDTO?.name)!;
            self.tableView.reloadData();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Buttons Action
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            if (self.filterDTO != nil) {
                return (self.filterDTO?.listSubFilters.count)!
            }
            return 0;
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        }
        
        if (indexPath.section == 0) {
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_ALL");
        }
        else {
            if (self.filterDTO != nil) {
                let subFilterDTO = self.filterDTO?.listSubFilters[indexPath.row];
                cell?.textLabel?.text = (subFilterDTO?.name)!
            }
            else {
                cell?.textLabel?.text = "";
            }
        }
        
        return cell!;
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            self.filterDTO?.selectedSubFilter = nil;
        }
        else {
            let subFilterDTO = self.filterDTO?.listSubFilters[indexPath.row];
            self.filterDTO?.selectedSubFilter = subFilterDTO;
        }
        _ = self.navigationController?.popViewController(animated: true);
    }

}
