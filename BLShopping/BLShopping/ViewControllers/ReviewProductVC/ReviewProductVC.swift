//
//  ReviewProductVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import SDWebImage

class ReviewProductVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var viewContainerReview: UIView!
    @IBOutlet weak var lblStatusReview: UILabel!
    @IBOutlet weak var txtReviewTitle: UITextField!
    @IBOutlet weak var txtReviewContent: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblPlaceHolderContent: UILabel!
    @IBOutlet weak var viewReviewTitle: UIView!
    @IBOutlet weak var viewReviewContent: UIView!
    
    var ratingView: EZRatingView!
    
    var productDTO: ProductDTO?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ratingView = EZRatingView(frame: CGRect(x: 0, y: 0, width: 100, height: 26));
        self.ratingView.markerDict = [EZMarkerBaseColorKey:UIColor.lightGray, EZMarkerCharacterFontKey:UIFont.systemFont(ofSize: 30)];
        self.ratingView.isUserInteractionEnabled = true;
        self.ratingView.sizeToFit();
        self.ratingView.minimumValue = 0;
        self.ratingView.stepInterval = 1;
        self.ratingView.center = CGPoint(x: self.viewContainerReview.frame.size.width/2, y: self.viewContainerReview.frame.size.height/2);
        self.viewContainerReview.addSubview(self.ratingView);
        self.ratingView.addTarget(self, action: #selector(self.ratingViewChange(sender:)), for: UIControlEvents.valueChanged);
        
        
        
        self.imageViewProduct.sd_setImage(with: URL(string: (self.productDTO?.thumbImageURL)!), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(), completed: { (image, error, cachedType, url) in
            if (error == nil) {
                self.imageViewProduct.image = image;
            }
        })
        
        self.lblProductName.text = (self.productDTO?.name)!;
        self.lblProductName.sizeToFit();
        
        self.viewReviewTitle.layer.borderColor = UIColor.lightGray.cgColor;
        self.viewReviewTitle.layer.borderWidth = 1;
        self.viewReviewContent.layer.borderColor = UIColor.lightGray.cgColor;
        self.viewReviewContent.layer.borderWidth = 1;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)));
        self.view.addGestureRecognizer(tap);
        
        self.scrollView.contentSize = CGSize(width: 0, height: self.btnSend.frame.origin.y + self.btnSend.frame.size.height + 20);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.ratingView.center = CGPoint(x: self.viewContainerReview.frame.size.width/2, y: self.viewContainerReview.frame.size.height/2);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.ratingView.center = CGPoint(x: self.viewContainerReview.frame.size.width/2, y: self.viewContainerReview.frame.size.height/2);
    }
    
    // MARK: - Show/hide keyboard
    @objc func keyboardWillShow(notification: Notification) -> Void {
        if (self.txtReviewTitle.isFirstResponder) {
            let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 150);
            self.scrollView.setContentOffset(offset, animated: true);
        }
        if (self.txtReviewContent.isFirstResponder) {
            let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 250);
            self.scrollView.setContentOffset(offset, animated: true);
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) -> Void {
        let offset = CGPoint(x: self.scrollView.contentOffset.x, y: 0);
        self.scrollView.setContentOffset(offset, animated: true);
    }
    
    // MARK: - Button Action
    @objc func handleTap(tap: UITapGestureRecognizer) {
        self.view.endEditing(true);
    }
    
    @IBAction func btnBackClicked(_ sender: Any?) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btnSendClicked(_ sender: Any) {
        let title = self.txtReviewTitle.text;
        let content = self.txtReviewContent.text;
        let rating = self.ratingView.value;
        
        if (title != "" && content != "" && rating > 0) {
            self.addReview(title: title!, content: content!, rating: rating);
        }
        else {
            showAlert(title: "", message: "Vui lòng nhập nhận xét của bạn", viewController: self);
        }
        
    }
    
    @objc func ratingViewChange(sender: Any) {
        let rating = self.ratingView.value;
        if (rating == 1) {
            self.lblStatusReview.text = "Rất không hài lòng";
            self.lblStatusReview.textColor = UIColor.red
        }
        else if (rating == 2) {
            self.lblStatusReview.text = "Không hài lòng";
            self.lblStatusReview.textColor = UIColor.red
        }
        else if (rating == 3) {
            self.lblStatusReview.text = "Bình thường";
            self.lblStatusReview.textColor = UIColor.green
        }
        else if (rating == 4) {
            self.lblStatusReview.text = "Hài lòng";
            self.lblStatusReview.textColor = UIColor.green
        }
        else if (rating == 5) {
            self.lblStatusReview.text = "Rất hài lòng";
            self.lblStatusReview.textColor = UIColor.green
        }
        else {
            self.lblStatusReview.text = "Bạn chưa đánh giá";
            self.lblStatusReview.textColor = UIColor.red
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder();
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        let content = self.txtReviewContent.text;
        if (content != "") {
            self.lblPlaceHolderContent.isHidden = true;
        }
        else {
            self.lblPlaceHolderContent.isHidden = false;
        }
    }
    
    // MARK: - CALL APIs
    func addReview(title: String, content: String, rating: CGFloat) {
        let userDTO = BLGlobal.shared.userDTO;
        var userID = "";
        if (userDTO != nil) {
            userID = (userDTO?.userID)!
        }
        
        //TODO: add review
        
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestAddProductReview(productDTO: self.productDTO!, title: title, content: content, rating: rating, userID: userID, completion: { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                //                print("requestAddProductReview: \(responseObject)")
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTI_ADD_REVIEW), object: nil);
//                self.btnBackClicked(nil);
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        })
    }

}
