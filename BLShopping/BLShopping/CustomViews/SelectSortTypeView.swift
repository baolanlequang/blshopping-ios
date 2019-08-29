//
//  SelectSortTypeView.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol SelectSortTypeViewDelegate {
    func onSelectedType(type: SortType);
}

class SelectSortTypeView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    
    var delegate: SelectSortTypeViewDelegate?;
    
    var currType = SortType.POSITION;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        self.btnClose.backgroundColor = BLColor.sharedInstance.defaultColor();
        self.btnClose.setTitleColor(BLColor.sharedInstance.textHighlightButtonColor(), for: .normal);
    }
    
    func show(type: SortType) {
        self.btnClose.setTitle(localizedString(key: "STR_LABEL_CLOSE"), for: .normal)
        
        self.currType = type;
        
        let appDelegate = UIApplication.shared.delegate;
        let window = appDelegate?.window;
        self.frame = (window??.frame)!;
        window??.addSubview(self);
        window??.bringSubviewToFront(self);
        
        self.tableView.reloadData();
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        }
        cell?.accessoryType = .none;
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_POSITION");
            if (self.currType == .POSITION) {
                cell?.accessoryType = .checkmark;
            }
            break;
        case 1:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_AZ");
            if (self.currType == .A_Z) {
                cell?.accessoryType = .checkmark;
            }
            break;
        case 2:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_ZA");
            if (self.currType == .Z_A) {
                cell?.accessoryType = .checkmark;
            }
            break;
        case 3:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_LOW_HIGH");
            if (self.currType == .LOW_HIGH) {
                cell?.accessoryType = .checkmark;
            }
            break;
        case 4:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_HIGH_LOW");
            if (self.currType == .HIGH_LOW) {
                cell?.accessoryType = .checkmark;
            }
            break;
        case 5:
            cell?.textLabel?.text = localizedString(key: "STR_LABEL_SORT_CREATED_BY");
            if (self.currType == .CREATED_BY) {
                cell?.accessoryType = .checkmark;
            }
            break;
        default:
            break;
        }
        
        return cell!;
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedType = SortType.POSITION;
        switch indexPath.row {
        case 0:
            selectedType = .POSITION
            break;
        case 1:
            selectedType = .A_Z
            break;
        case 2:
            selectedType = .Z_A
            break;
        case 3:
            selectedType = .LOW_HIGH
            break;
        case 4:
            selectedType = .HIGH_LOW
            break;
        case 5:
            selectedType = .CREATED_BY
            break;
        default:
            break;
        }
        
        if (selectedType != self.currType) {
            self.delegate?.onSelectedType(type: selectedType);
        }
        self.removeFromSuperview();
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.removeFromSuperview();
    }

}
