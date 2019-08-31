//
//  ProductInfoCartCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class ProductInfoCartCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var lblNumberProduct: UILabel!
    @IBOutlet weak var lblManufacture: UILabel!
    
    
    var currProduct: ProductDTO?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(arrProductDTO: [ProductDTO]) {
        let productDTO = arrProductDTO.first;
        self.currProduct = productDTO;
        
        if ((productDTO?.listManufactures.count)! > 0) {
            self.lblManufacture.text = productDTO?.listManufactures.first?.name;
        }
        
        
        self.imageViewProduct.sd_setImage(with: URL(string: (productDTO?.fullSizeImageURL)!), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
        
        self.lblName.text = productDTO?.name;
        self.lblPrice.text = productDTO?.price;
        self.lblNumberProduct.text = "\(arrProductDTO.count)";
        
        if (productDTO?.priceBeforeDiscount != "") {
            let priceDiscountStr = productDTO?.priceBeforeDiscount;
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: priceDiscountStr!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            self.lblOldPrice.attributedText = attributeString;
        }
        else {
            self.lblOldPrice.text = "";
        }
        
        self.lblName.sizeToFit();
        self.lblPrice.sizeToFit();
        self.lblOldPrice.sizeToFit();
    }
    
    @IBAction func btnRemoveClicked(_ sender: Any) {
        //TODO: remove product in cart
//        BLGlobal.shared.cartDTO.removeProduct(productID: (self.currProduct?.ID)!);
    }
    
    @IBAction func btnAddClicked(_ sender: Any) {
        //TODO: remove product to cart
//        BLGlobal.shared.cartDTO.addProduct(productDTO: self.currProduct!);
    }
    
    @IBAction func btnRemoveAllClicked(_ sender: Any) {
        //TODO: remove all product in cart
//        BLGlobal.shared.cartDTO.removeAllProductWithID(productID: (self.currProduct?.ID)!);
    }
}
