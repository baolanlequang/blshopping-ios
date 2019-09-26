//
//  ProductDetailVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/29/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class ProductDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ProductInfoCellDelegate, ProductManufactureCellDelegate, RelatedProductsCellDelegate, OverviewReviewsCellDelegate {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var btnLove: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var productDTO: ProductDTO?;
    var listRelatedProduct: [ProductDTO] = [];
    var listReviews: [ProductReviewDTO] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        //set color
        self.viewTop.backgroundColor = BLColor.sharedInstance.defaultColor();
        self.btnAddToCart.backgroundColor = BLColor.sharedInstance.highlightButtonColor();
        self.btnAddToCart.setTitleColor(BLColor.sharedInstance.textHighlightButtonColor(), for: .normal)
        
        self.btnCart.shouldHideBadgeAtZero = true;
        
        self.getProductDetail();
        self.getRelatedProducts();
        self.getReview();
        
        // register Notification
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotifications(noti:)), name: NSNotification.Name(rawValue: NOTI_ADD_REVIEW), object: nil);
        
        BLGlobal.shared.saveRecentOpenProduct(productDTO: (self.productDTO)!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.btnAddToCart.setTitle(localizedString(key: "STR_LABEL_ADD_TO_CART"), for: .normal);
        
        //TODO: show number product in cart
//        self.btnCart.badgeValue = "\(BLGlobal.shared.cartDTO.getTotalProducts())";
//        self.btnCart.badgeOriginX = 22;
//        self.btnCart.badgeOriginY = 2;
//        self.btnCart.badgePadding = 3;
    }
    
    //MARK: - Receive Notifications
    @objc func receiveNotifications(noti: Notification) -> Void {
        if noti.name == NSNotification.Name(rawValue: NOTI_ADD_REVIEW) {
            self.getProductDetail();
            self.getReview();
        }
    }
    
    // MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func btnAddToCartClicked(_ sender: Any) {
        let price = self.productDTO?.price;
        if (price?.lowercased().contains("call"))! {
            var phone = price?.lowercased().replacingOccurrences(of: "call", with: "");
            phone = phone?.replacingOccurrences(of: " ", with: "");
            if (phone != nil) {
                if let url = NSURL(string: "tel://\(phone!)"), UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
        else {
            //TODO: show number product in cart
//            BLGlobal.shared.cartDTO.addProduct(productDTO: self.productDTO!);
//            self.btnCart.badgeValue = "\(BLGlobal.shared.cartDTO.getTotalProducts())";
//            self.btnCart.badgeOriginX = 22;
//            self.btnCart.badgeOriginY = 2;
//            self.btnCart.badgePadding = 3;
        }
        
        
        
    }
    
    @IBAction func btnCartClicked(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2;
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            //manufactures
            if ((self.productDTO?.listManufactures.count)! == 0) {
                return 0;
            }
        }
        else if (section == 3) {
            if (self.productDTO?.shortDescription == "") {
                return 0;
            }
        }
        else if (section == 4) {
            if (self.listRelatedProduct.count == 0) {
                return 0;
            }
        }
        else if (section == 5) {
            if (self.listReviews.count > 0) {
                if (self.listReviews.count >= 2) {
                    return 4;
                }
                else {
                    return self.listReviews.count + 2;
                }
            }
            else {
                return 2;
            }
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: ProductInfoCell? = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell") as? ProductInfoCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductInfoCell", owner: self, options: nil)?.first as? ProductInfoCell;
                cell?.delegate = self;
            }
            cell?.setData(productDTO: self.productDTO!);
            return cell!;
        }
        else if (indexPath.section == 1) {
            var cell: ProductManufactureCell? = tableView.dequeueReusableCell(withIdentifier: "ProductManufactureCell") as? ProductManufactureCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductManufactureCell", owner: self, options: nil)?.first as? ProductManufactureCell;
            }
            cell?.delegate = self;
            cell?.setData(productDTO: self.productDTO!);
            return cell!;
        }
        else if (indexPath.section == 2) {
            var cell: ProductSpecsCell? = tableView.dequeueReusableCell(withIdentifier: "ProductSpecsCell") as? ProductSpecsCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductSpecsCell", owner: self, options: nil)?.first as? ProductSpecsCell;
            }
            cell?.setData(productDTO: self.productDTO!);
            return cell!;
        }
        else if (indexPath.section == 3) {
            var cell: ProductDescriptionCell? = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionCell") as? ProductDescriptionCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("ProductDescriptionCell", owner: self, options: nil)?.first as? ProductDescriptionCell;
            }
            cell?.setData(productDTO: self.productDTO!);
            return cell!;
        }
        else if (indexPath.section == 4) {
            var cell: RelatedProductsCell? = tableView.dequeueReusableCell(withIdentifier: "RelatedProductsCell") as? RelatedProductsCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("RelatedProductsCell", owner: self, options: nil)?.first as? RelatedProductsCell;
            }
            cell?.setData(listProducts: self.listRelatedProduct);
            cell?.delegate = self;
            return cell!;
        }
        else if (indexPath.section == 5) {
            if (indexPath.row == 0) {
                var cell: OverviewReviewsCell? = tableView.dequeueReusableCell(withIdentifier: "OverviewReviewsCell") as? OverviewReviewsCell;
                if (cell == nil) {
                    cell = Bundle.main.loadNibNamed("OverviewReviewsCell", owner: self, options: nil)?.first as? OverviewReviewsCell;
                }
                cell?.delegate = self;
                cell?.setData(listReview: self.listReviews, productDTO: self.productDTO!);
                return cell!;
            }
            else if (indexPath.row == self.listReviews.count + 1) {
                var cell: SeeAllReviewsCell? = tableView.dequeueReusableCell(withIdentifier: "SeeAllReviewsCell") as? SeeAllReviewsCell;
                if (cell == nil) {
                    cell = Bundle.main.loadNibNamed("SeeAllReviewsCell", owner: self, options: nil)?.first as? SeeAllReviewsCell;
                }
                if (self.listReviews.count > 2) {
                    cell?.setHeight(height: 44);
                }
                else {
                    cell?.setHeight(height: 0);
                }
                return cell!;
            }
            else {
                var cell: CustomerReviewCell? = tableView.dequeueReusableCell(withIdentifier: "CustomerReviewCell") as? CustomerReviewCell;
                if (cell == nil) {
                    cell = Bundle.main.loadNibNamed("CustomerReviewCell", owner: self, options: nil)?.first as? CustomerReviewCell;
                }
                let reviewDTO = self.listReviews[indexPath.row - 1];
                cell?.setData(reviewDTO: reviewDTO);
                return cell!;
            }
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
            return cell!;
        }
    }
    
    // MARK: - ProductInfoCellDelegate
    func openProductPhoto(productDTO: ProductDTO, index: Int) {
        //TODO: openProductPhoto
//        let photoViewer = PhotoViewerVC(nibName: "PhotoViewerVC", bundle: nil);
//        photoViewer.listPhotos = productDTO.listPics;
//        self.present(photoViewer, animated: true, completion: nil);
    }
    
    // MARK: -  OverviewReviewsCellDelegate
    func openReviewProduct() {
        if (BLGlobal.shared.userDTO != nil) {
            let reviewProductVC = ReviewProductVC(nibName: "ReviewProductVC", bundle: nil);
            reviewProductVC.productDTO = self.productDTO;
            self.navigationController?.present(reviewProductVC, animated: true, completion: nil);
        }
    }
    
    // MARK: - RelatedProductsCellDelegate
    func selectRelatedProduct(productDTO: ProductDTO) {
        let productDetailVC = ProductDetailVC(nibName: "ProductDetailVC", bundle: nil);
        productDetailVC.productDTO = productDTO;
        self.navigationController?.pushViewController(productDetailVC, animated: true);
    }
    
    // MARK: - ProductManufactureCellDelegate
    func openManufacture(manufacture: ManufactureDTO) {
        let listProductVC = ListProductManuVC(nibName: "ListProductManuVC", bundle: nil);
        listProductVC.manufactureDTO = manufacture;
        self.navigationController?.pushViewController(listProductVC, animated: true);
    }
    
    // MARK: - CALL APIs
    func getProductDetail() {
        if (self.productDTO != nil) {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            requestProductDetails(productID: self.productDTO!.ID, completion: { (operation, responseObject, error) in
                hud.hide(animated: true);
                if (error == nil) {
//                    print("requestGetProductDetail: \(responseObject)");
                    let json = JSON(responseObject ?? [:]);
                    let status = json["status"];
                    if (status["code"].intValue == 1) {
                        let productData = json["data"];
                        self.productDTO = ProductDTO(jsonData: productData);
                        self.tableView.reloadData()
                        
                        let price = self.productDTO?.price;
                        if (price?.lowercased().contains("call"))! {
                            self.btnAddToCart.setTitle("Liên Hệ Nhà Cung Cấp", for: .normal);
                        }
                        else {
                            self.btnAddToCart.setTitle("Thêm Vào Giỏ Hàng", for: .normal);
                        }

                    }
                }
                else {

                }
            })
        }
    }
    
    func getRelatedProducts() {
        if (self.productDTO != nil) {
            //TODO: get related product
            
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//            requestGetRelatedProducts(productDTO: self.productDTO!, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestGetRelatedProducts: \(responseObject)");
//                    let json = JSON(responseObject ?? [:]);
//                    if (json["RelatedProductsResult"].array != nil) {
//                        for jsonData in json["RelatedProductsResult"].arrayValue {
//                            let product = ProductDTO(jsonData: jsonData);
//                            self.listRelatedProduct.append(product);
//                        }
//                        self.tableView.reloadData();
//                    }
//                }
//                else {
//
//                }
//            })
        }
    }
    
    func getReview() {
        if (self.productDTO != nil) {
            //TODO: get product review
            
//            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//            requestGetProductReview(productDTO: self.productDTO!, completion: { (operation, responseObject, error) in
//                hud.hide(animated: true);
//                if (error == nil) {
//                    //                    print("requestGetProductReview: \(responseObject)");
//                    let json = JSON(responseObject ?? [:]);
//                    if (json["ProductReviewsResult"].dictionary != nil) {
//                        if (json["ProductReviewsResult"]["Items"].array != nil) {
//                            self.listReviews.removeAll();
//                            for jsonData in json["ProductReviewsResult"]["Items"].arrayValue {
//                                let reviewDTO = ProductReviewDTO(jsonData: jsonData);
//                                self.listReviews.append(reviewDTO);
//                            }
//                            self.tableView.reloadData();
//                        }
//
//                    }
//                }
//                else {
//
//                }
//            })
        }
    }

}
