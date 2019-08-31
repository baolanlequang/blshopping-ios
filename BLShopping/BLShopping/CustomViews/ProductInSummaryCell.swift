//
//  ProductInSummaryCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class ProductInSummaryCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var lblNumberProduct: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(productDTO: ProductDTO) {
        self.imageViewProduct.sd_setImage(with: URL(string: productDTO.fullSizeImageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
        
        self.lblName.text = productDTO.name;
        self.lblName.sizeToFit();
        self.lblPrice.text = productDTO.price;
        self.lblNumberProduct.text = "\(productDTO.quantity)"
        
        
        var totalAmount = 0.0;
        var price = productDTO.price;
        if (price.contains("₫")) {
            price = price.replacingOccurrences(of: "₫", with: "");
            price = price.replacingOccurrences(of: ".", with: "");
            if (Double(price) != nil) {
                totalAmount = Double(price)! * Double(productDTO.quantity);
            }
        }
        if (totalAmount > 0) {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "vi_VN");
            formatter.numberStyle = .currency
            if let formattedAmount = formatter.string(from: totalAmount as NSNumber) {
                self.lblTotalAmount.text = "\(formattedAmount)"
            }
        }
        else {
            self.lblTotalAmount.text = "Liên hệ nhà cung cấp";
        }
    }
}
