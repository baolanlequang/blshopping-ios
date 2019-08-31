//
//  PhotoViewerLargeCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewerLargeCell: UICollectionViewCell , UIScrollViewDelegate {
    
    @IBOutlet weak var scrollViewZoom: UIScrollView!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.scrollViewZoom.minimumZoomScale = 1.0;
        self.scrollViewZoom.maximumZoomScale = 6.0;
    }
    
    func setData(photo: ProductPictureDTO) {
        self.imageViewProduct.sd_setImage(with: URL(string: photo.fullSizeImageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageViewProduct;
    }

}
