//
//  HomeCategoryCollectionCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var imageViewThumb: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(categoryDTO: CategoryDTO) {
        self.lblName.text = categoryDTO.name;
        
        if (categoryDTO.name != "") {
            let range = NSMakeRange(0, 1);
            let strPhone = categoryDTO.name as NSString;
            let subStr = strPhone.substring(with: range);
            self.lblImage.text = subStr.uppercased();
        }
        
        self.imageViewThumb.sd_setImage(with: URL(string: categoryDTO.thumbnail), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewThumb.image = image;
            }
        });
        
    }

}
