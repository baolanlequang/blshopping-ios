//
//  CategoryCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/27/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
    func openSeeMoreCategory(catDTO: CategoryDTO);
    func openProductDetail(productDTO: ProductDTO);
}

class CategoryCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //variables
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnExploreMore: UIButton!
    
    @IBOutlet weak var heightTitle: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightBtnSeeAll: NSLayoutConstraint!
    
    //data
    var currCatDTO: CategoryDTO?
    
    //callback
    var delegate: CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib(nibName: "CategoryProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryProductCollectionCell");
        
        //set color
        self.lblName.textColor = BLColor.sharedInstance.defaultTextColor();
        self.btnExploreMore.setTitleColor(BLColor.sharedInstance.defaultColor(), for: .normal);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(catDTO: CategoryDTO) {
        self.currCatDTO = catDTO;

        self.lblName.text = catDTO.name;
        
        self.btnExploreMore.setTitle(localizedString(key: "STR_LABEL_WATCH_MORE"), for: .normal)

        if (catDTO.listFirstFourProduct.count == 0) {
            self.heightTitle.constant = 0;
            self.heightCollectionView.constant = 0;
            self.heightBtnSeeAll.constant = 0;
        }
        else {
            self.heightTitle.constant = 44;
            if (checkIsIpad()) {
                self.heightCollectionView.constant = 600;
            }
            else {
                self.heightCollectionView.constant = 400;
            }
            self.heightBtnSeeAll.constant = 44;
        }
        self.collectionView.reloadData();
    }
    
    // MARK: - Buttons Action
    @IBAction func btnSeeMoreClicked(_ sender: Any) {
        if (self.currCatDTO != nil) {
            self.delegate?.openSeeMoreCategory(catDTO: self.currCatDTO!);
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.currCatDTO != nil) {
            return (self.currCatDTO?.listFirstFourProduct.count)!;
        }
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: CategoryProductCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryProductCollectionCell", for: indexPath) as? CategoryProductCollectionCell;
        if (cell == nil) {
            if (checkIsIpad()) {
                cell = CategoryProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 320, height: 300));
            }
            else {
                cell = CategoryProductCollectionCell(frame: CGRect(x: 0, y: 0, width: 320, height: 200));
            }
        }
        
        if (self.currCatDTO != nil) {
            let productDTO = self.currCatDTO?.listFirstFourProduct[indexPath.row];
            cell?.setData(productDTO: productDTO!);
        }
        
        return cell!;
        
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (checkIsIpad()) {
            return CGSize(width: collectionView.frame.size.width/2, height: 300);
        }
        return CGSize(width: collectionView.frame.size.width/2, height: 200);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDTO = self.currCatDTO?.listFirstFourProduct[indexPath.row];
        self.delegate?.openProductDetail(productDTO: productDTO!);
    }
}
