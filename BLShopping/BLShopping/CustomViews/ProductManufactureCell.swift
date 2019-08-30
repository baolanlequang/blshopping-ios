//
//  ProductManufactureCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol ProductManufactureCellDelegate {
    func openManufacture(manufacture: ManufactureDTO);
}

class ProductManufactureCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitleManufacture: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var delegate: ProductManufactureCellDelegate?;
    
    var manufactureDTO: ManufactureDTO?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set color
        self.lblTitle.textColor = BLColor.sharedInstance.defaultTextColor();
        self.lblTitleManufacture.textColor = BLColor.sharedInstance.defaultTextColorDark();
        self.lblName.textColor = BLColor.sharedInstance.defaultColor();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(productDTO: ProductDTO) {
        self.lblTitle.text = localizedString(key: "STR_LABEL_MANUFACTURER")
        self.lblTitleManufacture.text = localizedString(key: "STR_LABEL_MANUFACTURED_BY")
        
        let manufacture = productDTO.listManufactures.first;
        
        self.lblName.text = manufacture?.name;
        self.manufactureDTO = manufacture;
    }
    
    @IBAction func btnManufactureClicked(_ sender: Any) {
        if (self.manufactureDTO != nil) {
            self.delegate?.openManufacture(manufacture: self.manufactureDTO!);
        }
    }
}
