//
//  AllCategoriesCollectionCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/27/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class AllCategoriesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var lblSeeAll: UILabel!
    @IBOutlet weak var lblImageCategory: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set color
        self.lblCategoryName.textColor = BLColor.sharedInstance.defaultTextColor();
        self.lblSeeAll.textColor = BLColor.sharedInstance.defaultColor();
    }

    func setData(categoryDTO: CategoryDTO?) {
        if (categoryDTO != nil) {
            self.lblCategoryName.text = categoryDTO?.name;
            self.lblSeeAll.isHidden = true;
            self.lblCategoryName.isHidden = false;
            self.imageViewCategory.isHidden = false;
            if (categoryDTO?.name != "") {
                let range = NSMakeRange(0, 1);
                let strPhone = categoryDTO!.name as NSString;
                let subStr = strPhone.substring(with: range);
                self.lblImageCategory.text = subStr.uppercased();
            }
            
            self.imageViewCategory.sd_setImage(with: URL(string: (categoryDTO?.thumbnail)!), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
                if (error == nil) {
                    self.imageViewCategory.image = image;
                }
            });
        }
        else {
            self.lblSeeAll.isHidden = false;
            self.lblCategoryName.isHidden = true;
            self.imageViewCategory.isHidden = true;
            self.lblImageCategory.isHidden = true;
        }
    }
}
