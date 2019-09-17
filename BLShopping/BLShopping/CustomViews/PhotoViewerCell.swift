//
//  PhotoViewerCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewerCell: UICollectionViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageViewProduct.layer.borderColor = UIColor.white.cgColor;
        self.imageViewProduct.layer.borderWidth = 1;
    }
    
    func updateBorder(isSelected: Bool) {
        if (isSelected) {
            self.imageViewProduct.layer.borderColor = UIColor.red.cgColor;
        }
        else {
            self.imageViewProduct.layer.borderColor = UIColor.white.cgColor;
        }
    }
    
    func setData(photo: ProductPictureDTO) {
        self.imageViewProduct.sd_setImage(with: URL(string: photo.imageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
    }

}
