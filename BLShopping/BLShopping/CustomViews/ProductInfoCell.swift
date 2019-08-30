//
//  ProductInfoCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProductInfoCellDelegate {
    func openProductPhoto(productDTO: ProductDTO, index: Int);
}

class ProductInfoCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var viewContainerRating: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollViewImage: UIScrollView!
    @IBOutlet weak var lblSKU: UILabel!
    
    var ratingView: EZRatingView!
    var currProductDTO: ProductDTO?;
    var delegate: ProductInfoCellDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.ratingView == nil) {
            self.ratingView = EZRatingView(frame: CGRect(x: 0, y: 0, width: 100, height: 26));
            self.ratingView.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingView.sizeToFit();
            self.ratingView.minimumValue = 0;
            self.ratingView.center = CGPoint(x: self.ratingView.center.x, y: self.viewContainerRating.frame.size.height/2);
            self.viewContainerRating.addSubview(self.ratingView);
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)));
        self.scrollViewImage.addGestureRecognizer(tap);
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(productDTO: ProductDTO) {
        self.currProductDTO = productDTO;
        
        self.lblName.text = productDTO.name;
        self.lblName.sizeToFit();
        
        self.lblSKU.text = "SKU: \(productDTO.ID)";
        
        self.pageControl.numberOfPages = productDTO.listPics.count;
        
        if (productDTO.totalReview > 0) {
            self.lblRating.text = String.init(format: "%.1f/5", productDTO.totalRating/Double(productDTO.totalReview));
            self.ratingView.value = CGFloat(productDTO.totalRating/Double(productDTO.totalReview));
        }
        else {
            self.lblRating.text = "0/5";
            self.ratingView.value = 0;
        }
        
        
        self.btnReview.setTitle("\(productDTO.totalReview) \(localizedString(key: "STR_LABEL_COMMENTS"))", for: .normal);
        
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
        
        for sub in self.scrollViewImage.subviews {
            sub.removeFromSuperview();
        }
        
        let imageWidth = getScreenRect().width;
        let imageHeight = self.scrollViewImage.frame.size.height;
        
        for (index, picDTO) in productDTO.listPics.enumerated() {
            let imageViewProd = UIImageView(frame: CGRect(x: CGFloat(index)*imageWidth, y: 0, width: imageWidth, height: imageHeight));
            imageViewProd.contentMode = .scaleAspectFit;
            imageViewProd.sd_setImage(with: URL(string: picDTO.fullSizeImageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
                if (error == nil) {
                    imageViewProd.image = image;
                }
            })
            self.scrollViewImage.addSubview(imageViewProd);
        }
        
        self.scrollViewImage.contentSize = CGSize(width: CGFloat(productDTO.listPics.count)*imageWidth, height: 0);
        
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x;
        let page = Int(offsetX/scrollView.frame.size.width);
        if (page >= 0 && page < self.pageControl.numberOfPages) {
            self.pageControl.currentPage = page;
        }
        
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if ((self.currProductDTO?.listPics.count)! > 0) {
            let index = self.pageControl.currentPage;
            self.delegate?.openProductPhoto(productDTO: self.currProductDTO!, index: index);
        }
    }
    
    // MARK: - Buttons Action
    @IBAction func btnCallClicked(_ sender: Any) {
        let price = (self.currProductDTO?.price)!.lowercased();
        if (price.contains("call")) {
            var phone: String = price;
            phone = phone.replacingOccurrences(of: "call", with: "");
            phone = phone.replacingOccurrences(of: " ", with: "");
            if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open((url as URL), options: [:], completionHandler: nil)
            }
        }
    }
    
}
