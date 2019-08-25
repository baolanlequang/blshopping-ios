//
//  ListStoreVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class ListStoreVC: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    
    // variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var bgSearchBar: UIView!
    
    @IBOutlet weak var heightTopBar: NSLayoutConstraint!
    
    //check scroll
    var lastContentOffset: CGFloat = 0;
    var isDragging = false;
    
    //data
    var listBanners: [BannerDTO] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true;
        self.edgesForExtendedLayout = [];
        
        self.bgSearchBar.layer.cornerRadius = 3;
        
        //get data
        self.getSlideBanner();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: localized and load list viewed product
//        self.listWatchedProduct.removeAll();
//        self.listWatchedProduct = BLGlobal.shared.getRecentOpenProducts();
        self.tableView.reloadData();
    }

    // MARK: - Buttons Action
    @IBAction func btnOpenSearchClicked(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1;
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
        
        //TODO: display more cate
//        return 8;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section == 7) {
//            return self.listSubCategory.count;
//        }
//        else if (section == 3) {
//            if (self.listBestSellerProduct.count > 0) {
//                return 1;
//            }
//            return 0;
//        }
//        else if (section == 4) {
//            if (self.listNewAddedProduct.count > 0) {
//                return 1;
//            }
//            return 0;
//        }
//        else if (section == 5) {
//            if (self.listHotProduct.count > 0) {
//                return 1;
//            }
//            return 0;
//        }
//        else if (section == 6) {
//            if (self.listWatchedProduct.count > 0) {
//                return 1;
//            }
//            return 0;
//        }
//        else if (section == 2) {
//            if (BLGlobal.shared.userDTO != nil) {
//                return 0;
//            }
//        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: BannerCell? = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as? BannerCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("BannerCell", owner: self, options: nil)?.first as? BannerCell;
            }
            cell?.setData(listBanner: self.listBanners);
            return cell!;
        }
//        else if (indexPath.section == 1) {
//            var cell: ListCategoryCell? = tableView.dequeueReusableCell(withIdentifier: "ListCategoryCell") as? ListCategoryCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("ListCategoryCell", owner: self, options: nil)?.first as? ListCategoryCell;
//            }
//            cell?.delegate = self;
//            cell?.setData(listCategory: self.listCategory);
//            return cell!;
//        }
//        else if (indexPath.section == 2) {
//            var cell: NeedLoginCell? = tableView.dequeueReusableCell(withIdentifier: "NeedLoginCell") as? NeedLoginCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("NeedLoginCell", owner: self, options: nil)?.first as? NeedLoginCell;
//            }
//            cell?.delegate = self;
//            return cell!;
//        }
//        else if (indexPath.section == 3) {
//            var cell: HotPromotionCell? = tableView.dequeueReusableCell(withIdentifier: "HotPromotionCell") as? HotPromotionCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("HotPromotionCell", owner: self, options: nil)?.first as? HotPromotionCell;
//            }
//            cell?.delegate = self;
//            cell?.setData(listProducts: self.listBestSellerProduct);
//            return cell!;
//        }
//        else if (indexPath.section == 4) {
//            var cell: ProductForYouCell? = tableView.dequeueReusableCell(withIdentifier: "ProductForYouCell") as? ProductForYouCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("ProductForYouCell", owner: self, options: nil)?.first as? ProductForYouCell;
//            }
//            cell?.delegate = self;
//            cell?.setData(listProducts: self.listNewAddedProduct);
//            cell?.lblTitle.text = "Sản Phẩm Mới";
//            return cell!;
//        }
//        else if (indexPath.section == 5) {
//            var cell: ProductForYouCell? = tableView.dequeueReusableCell(withIdentifier: "ProductForYouCell") as? ProductForYouCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("ProductForYouCell", owner: self, options: nil)?.first as? ProductForYouCell;
//            }
//            cell?.delegate = self;
//            cell?.setData(listProducts: self.listHotProduct);
//            cell?.lblTitle.text = "Sản Phẩm HOT";
//            return cell!;
//        }
//        else if (indexPath.section == 6) {
//            var cell: ProductForYouCell? = tableView.dequeueReusableCell(withIdentifier: "ProductForYouCell") as? ProductForYouCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("ProductForYouCell", owner: self, options: nil)?.first as? ProductForYouCell;
//            }
//            cell?.delegate = self;
//            cell?.setData(listProducts: self.listWatchedProduct);
//            cell?.lblTitle.text = "Sản Phẩm Đã Xem";
//            return cell!;
//        }
//        else if (indexPath.section == 7) {
//            var cell: CategoryCell? = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell;
//            if (cell == nil) {
//                cell = Bundle.main.loadNibNamed("CategoryCell", owner: self, options: nil)?.first as? CategoryCell;
//            }
//            cell?.delegate = self;
//            let subCatDTO = self.listSubCategory[indexPath.row];
//            cell?.setData(subCatDTO: subCatDTO);
//            return cell!;
//        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
            return cell!;
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let distance = abs(self.lastContentOffset - scrollView.contentOffset.y);
        
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            if (self.isDragging) {
                if (self.topBarView.frame.origin.y < 0) {
                    var topBarFrame = self.topBarView.frame;
                    topBarFrame.origin.y += distance;
                    if (topBarFrame.origin.y > 0) {
                        topBarFrame.origin.y = 0;
                    }
                    self.topBarView.frame = topBarFrame

                }
            }
            
        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
            if (self.isDragging) {
                if (checkIsIpad()) {
                    if (self.topBarView.frame.origin.y > -100) {
                        var topBarFrame = self.topBarView.frame;
                        topBarFrame.origin.y -= distance;
                        if (topBarFrame.origin.y < -100) {
                            topBarFrame.origin.y = -100;
                        }
                        self.topBarView.frame = topBarFrame
                    }
                }
                else {
                    if (self.topBarView.frame.origin.y > -55) {
                        var topBarFrame = self.topBarView.frame;
                        topBarFrame.origin.y -= distance;
                        if (topBarFrame.origin.y < -55) {
                            topBarFrame.origin.y = -55;
                        }
                        self.topBarView.frame = topBarFrame
                        
//                        var tableviewFrame = self.tableView.frame;
//                        tableviewFrame.origin.y = topBarFrame.origin.y + topBarFrame.size.height;
//                        tableviewFrame.size.height = self.view.frame.size.height - tableviewFrame.origin.y;
//                        self.tableView.frame = tableviewFrame;
                    }
                }
                
            }
        }
        
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (checkIsIpad()) {
            if (self.topBarView.frame.origin.y > -100 && self.topBarView.frame.origin.y < -55) {
                var topBarFrame = self.topBarView.frame;
                topBarFrame.origin.y = -100;
                self.topBarView.frame = topBarFrame
            }
            else if (self.topBarView.frame.origin.y >= -55 && self.topBarView.frame.origin.y < 0) {
                var topBarFrame = self.topBarView.frame;
                topBarFrame.origin.y = 0;
                self.topBarView.frame = topBarFrame

            }
        }
        else {
            if (self.topBarView.frame.origin.y > -55 && self.topBarView.frame.origin.y < -25) {
                var topBarFrame = self.topBarView.frame;
                topBarFrame.origin.y = -55;
                self.topBarView.frame = topBarFrame
            }
            else if (self.topBarView.frame.origin.y >= -25 && self.topBarView.frame.origin.y < 0) {
                var topBarFrame = self.topBarView.frame;
                topBarFrame.origin.y = 0;
                self.topBarView.frame = topBarFrame

            }
        }
        
    }
    
    // MARK: - CALL APIs
    func getSlideBanner() {
        
        //TODO: demo banner
        let banner1 = BannerDTO(bannerID: "1", content: "", imageURL: "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg", link: "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg")
        let banner2 = BannerDTO(bannerID: "2", content: "", imageURL: "https://cdn.pixabay.com/photo/2014/04/14/20/11/japanese-cherry-trees-324175_1280.jpg", link: "https://cdn.pixabay.com/photo/2014/04/14/20/11/japanese-cherry-trees-324175_1280.jpg")
        let banner3 = BannerDTO(bannerID: "3", content: "", imageURL: "https://cdn.pixabay.com/photo/2013/10/02/23/03/dawn-190055_1280.jpg", link: "https://cdn.pixabay.com/photo/2013/10/02/23/03/dawn-190055_1280.jpg");
        self.listBanners.append(banner1)
        self.listBanners.append(banner2)
        self.listBanners.append(banner3)
        self.tableView.reloadData()
        
        
        
        //TODO: load banner
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestGetSlideBanner { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json["NivoSliderResult"].dictionary != nil) {
//                    let dicBanner = json["NivoSliderResult"];
//                    for i in 1...5 {
//                        let picStr = "Picture\(i)Url";
//                        let linkStr = "Link\(i)";
//                        let contentStr = "Text\(i)";
//                        if (dicBanner[picStr].string != nil) {
//                            let bannerDTO = BannerDTO();
//                            bannerDTO.imageURL = dicBanner[picStr].stringValue;
//                            if (dicBanner[linkStr].string != nil) {
//                                bannerDTO.link = dicBanner[linkStr].stringValue;
//                            }
//                            if (dicBanner[contentStr].string != nil) {
//                                bannerDTO.content = dicBanner[contentStr].stringValue;
//                            }
//                            self.listBanners.append(bannerDTO);
//                        }
//                    }
//                    self.tableView.reloadData();
//                }
//            }
//            else {
//
//            }
//        }
    }
}
