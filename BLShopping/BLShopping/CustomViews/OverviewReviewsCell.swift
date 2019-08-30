//
//  OverviewReviewsCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol OverviewReviewsCellDelegate {
    func openReviewProduct();
}

class OverviewReviewsCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblNumberReview: UILabel!
    @IBOutlet weak var viewTotalRating: UIView!
    @IBOutlet weak var viewRatingDetail: UIView!
    
    @IBOutlet weak var progressFiveStar: UIProgressView!
    @IBOutlet weak var progressFourStar: UIProgressView!
    @IBOutlet weak var progressThreeStar: UIProgressView!
    @IBOutlet weak var progressTwoStar: UIProgressView!
    @IBOutlet weak var progressOneStar: UIProgressView!
    
    @IBOutlet weak var lblFiveStar: UILabel!
    @IBOutlet weak var lblFourStar: UILabel!
    @IBOutlet weak var lblThreeStar: UILabel!
    @IBOutlet weak var lblTwoStar: UILabel!
    @IBOutlet weak var lblOneStar: UILabel!
    
    var ratingView: EZRatingView!
    var ratingViewFiveStar: EZRatingView!
    var ratingViewFourStar: EZRatingView!
    var ratingViewThreeStar: EZRatingView!
    var ratingViewTwoStar: EZRatingView!
    var ratingViewOneStar: EZRatingView!
    
    var delegate: OverviewReviewsCellDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if (self.ratingView == nil) {
            self.ratingView = EZRatingView(frame: CGRect(x: 0, y: 0, width: 50, height: 26));
            self.ratingView.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 20)];
            self.ratingView.sizeToFit();
            self.ratingView.minimumValue = 0;
            self.ratingView.center = CGPoint(x: self.viewTotalRating.frame.size.width/2, y: self.viewTotalRating.frame.size.height/2);
            self.viewTotalRating.addSubview(self.ratingView);
            
            self.ratingViewFiveStar = EZRatingView(frame: CGRect(x: 5, y: 10, width: 50, height: 15));
            self.ratingViewFiveStar.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingViewFiveStar.sizeToFit();
            self.ratingViewFiveStar.value = 5;
            self.viewRatingDetail.addSubview(self.ratingViewFiveStar);
            
            self.ratingViewFourStar = EZRatingView(frame: CGRect(x: 5, y: 25, width: 50, height: 15));
            self.ratingViewFourStar.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingViewFourStar.sizeToFit();
            self.ratingViewFourStar.value = 4;
            self.viewRatingDetail.addSubview(self.ratingViewFourStar);
            
            self.ratingViewThreeStar = EZRatingView(frame: CGRect(x: 5, y: 40, width: 50, height: 15));
            self.ratingViewThreeStar.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingViewThreeStar.sizeToFit();
            self.ratingViewThreeStar.value = 3;
            self.viewRatingDetail.addSubview(self.ratingViewThreeStar);
            
            self.ratingViewTwoStar = EZRatingView(frame: CGRect(x: 5, y: 55, width: 50, height: 15));
            self.ratingViewTwoStar.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingViewTwoStar.sizeToFit();
            self.ratingViewTwoStar.value = 2;
            self.viewRatingDetail.addSubview(self.ratingViewTwoStar);
            
            self.ratingViewOneStar = EZRatingView(frame: CGRect(x: 5, y: 70, width: 50, height: 15));
            self.ratingViewOneStar.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 12)];
            self.ratingViewOneStar.sizeToFit();
            self.ratingViewOneStar.value = 1;
            self.viewRatingDetail.addSubview(self.ratingViewOneStar);
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(listReview: [ProductReviewDTO], productDTO: ProductDTO) {
        if (productDTO.totalReview > 0) {
            self.lblRating.text = String.init(format: "%.1f/5", productDTO.totalRating/Double(productDTO.totalReview));
            self.ratingView.value = CGFloat(productDTO.totalRating/Double(productDTO.totalReview));
        }
        else {
            self.lblRating.text = "0/5"
            self.ratingView.value = 0;
        }
        
        self.lblNumberReview.text = "\(productDTO.totalReview) nhận xét";
        
        
        self.ratingView.center = CGPoint(x: self.lblRating.center.x, y: self.viewTotalRating.frame.size.height/2)
        
        let arrFive = listReview.filter { (reviewDTO) -> Bool in
            return reviewDTO.rating >= 4.5;
        }
        let arrFour = listReview.filter { (reviewDTO) -> Bool in
            return (reviewDTO.rating >= 3.5 && reviewDTO.rating < 4.5);
        }
        let arrThree = listReview.filter { (reviewDTO) -> Bool in
            return (reviewDTO.rating >= 2.5 && reviewDTO.rating < 3.5);
        }
        let arrTwo = listReview.filter { (reviewDTO) -> Bool in
            return (reviewDTO.rating >= 1.5 && reviewDTO.rating < 2.5);
        }
        let arrOne = listReview.filter { (reviewDTO) -> Bool in
            return (reviewDTO.rating > 0 && reviewDTO.rating < 1.5);
        }
        
        let totalReview:Float = Float(listReview.count);
        if (totalReview > 0) {
            self.progressFiveStar.progress = Float(arrFive.count)/totalReview;
            self.progressFourStar.progress = Float(arrFour.count)/totalReview;
            self.progressThreeStar.progress = Float(arrThree.count)/totalReview;
            self.progressTwoStar.progress = Float(arrTwo.count)/totalReview;
            self.progressOneStar.progress = Float(arrOne.count)/totalReview;
        }
        
        
        self.lblFiveStar.text = "\(Int(self.progressFiveStar.progress * 100))%"
        self.lblFourStar.text = "\(Int(self.progressFourStar.progress * 100))%"
        self.lblThreeStar.text = "\(Int(self.progressThreeStar.progress * 100))%"
        self.lblTwoStar.text = "\(Int(self.progressTwoStar.progress * 100))%"
        self.lblOneStar.text = "\(Int(self.progressOneStar.progress * 100))%"
    }
    
    @IBAction func btnEnterReviewClicked(_ sender: Any) {
        self.delegate?.openReviewProduct();
    }
}
