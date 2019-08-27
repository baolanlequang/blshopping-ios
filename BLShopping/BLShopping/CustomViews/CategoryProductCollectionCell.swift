//
//  CategoryProductCollectionCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/27/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryProductCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblPriceDiscount: UILabel!
    
    var currProductDTO: ProductDTO?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set color
        self.lblProductName.textColor = BLColor.sharedInstance.defaultTextColor();
        self.lblProductPrice.textColor = BLColor.sharedInstance.highlightButtonColor();
        self.lblPriceDiscount.textColor = BLColor.sharedInstance.textHintColor();
    }

    func setData(productDTO: ProductDTO) {
        self.currProductDTO = productDTO;
        self.imageViewProduct.sd_setImage(with: URL(string: productDTO.imageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
        
        self.lblProductName.text = productDTO.name;
        self.lblProductPrice.text = productDTO.price;
        
        if (productDTO.priceBeforeDiscount != "") {
            let priceDiscountStr = productDTO.priceBeforeDiscount;
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: priceDiscountStr)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            self.lblPriceDiscount.attributedText = attributeString;
        }
        else {
            self.lblPriceDiscount.text = "";
        }
    }
}
