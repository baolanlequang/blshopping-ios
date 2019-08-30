//
//  CustomerReviewCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class CustomerReviewCell: UITableViewCell {
    
    var ratingView: EZRatingView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.ratingView == nil) {
            self.ratingView = EZRatingView(frame: CGRect(x: 8, y: 10, width: 100, height: 26));
            self.ratingView.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 10)];
            self.ratingView.sizeToFit();
            self.contentView.addSubview(self.ratingView);
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(reviewDTO: ProductReviewDTO) {
        self.ratingView.value = CGFloat(reviewDTO.rating);
        self.lblTitle.text = reviewDTO.title;
        
        self.lblDate.text = "\(reviewDTO.customerName) - \(reviewDTO.reviewDate)"
        
        self.lblContent.text = reviewDTO.content;
        
    }
    
}
