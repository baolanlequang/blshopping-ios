//
//  BannerCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var listBanners: [BannerDTO]?;

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)));
        self.scrollView.addGestureRecognizer(tap);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(listBanner: [BannerDTO]) {
        self.listBanners = listBanner;
        
        for sub in self.scrollView.subviews {
            sub.removeFromSuperview();
        }
        
        self.pageController.numberOfPages = listBanner.count;
        
        let width = getScreenRect().width;
        let height = self.scrollView.frame.size.height;
        for (index,bannerDTO) in listBanner.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height));
            imageView.sd_setImage(with: URL(string: bannerDTO.imageURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
                if (error == nil) {
                    imageView.image = image;
                }
            })
            self.scrollView.addSubview(imageView);
        }
        self.scrollView.contentSize = CGSize(width: CGFloat(listBanner.count)*width, height: 0);
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        let index = self.pageController.currentPage;
        if ((self.listBanners?.count)! > 0) {
            let bannerDTO = self.listBanners?[index];
            let link = bannerDTO?.link;
            if (link != nil) {
                let escapedString = link?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let urlcomponents = URLComponents(string: escapedString!);
                if (UIApplication.shared.canOpenURL((urlcomponents?.url)!)) {
                    UIApplication.shared.openURL((urlcomponents?.url)!);
                }
                
            }
            
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = getScreenRect().width;
        let offsetX = scrollView.contentOffset.x
        let page = Int(offsetX/width);
        self.pageController.currentPage = page;
    }
}
