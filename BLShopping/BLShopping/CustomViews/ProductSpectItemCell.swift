//
//  ProductSpectItemCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ProductSpectItemCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: set color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(specDTO: ProductSpecsDTO) {
        self.lblName.text = specDTO.name;
        self.lblValue.text = specDTO.value;
    }
    
}
