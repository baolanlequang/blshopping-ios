//
//  BestSellerProductCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class BestSellerProductCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set color
        self.lblName.textColor = BLColor.sharedInstance.defaultTextColor();
        self.lblPrice.textColor = BLColor.sharedInstance.highlightButtonColor();
        self.lblOldPrice.textColor = BLColor.sharedInstance.textHintColor();
    }

    func setData(productDTO: ProductDTO) {
        
        self.imageViewProduct.sd_setImage(with: URL(string: productDTO.imageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
        
        self.lblName.text = productDTO.name;
        self.lblPrice.text = productDTO.price;
        
        if (productDTO.priceBeforeDiscount != "") {
            let priceDiscountStr = productDTO.priceBeforeDiscount;
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: priceDiscountStr)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            self.lblOldPrice.attributedText = attributeString;
        }
        else {
            self.lblOldPrice.text = "";
        }
        
        
    }
}
