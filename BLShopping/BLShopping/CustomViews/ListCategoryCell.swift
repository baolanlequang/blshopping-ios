//
//  ListCategoryCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/25/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol ListCategoryCellDelegate {
    func openSeeAllCategory();
    func openCategoryDetail(categoryDTO: CategoryDTO);
}

class ListCategoryCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // variables
    @IBOutlet weak var collectionView: UICollectionView!
    
    //call back
    var delegate: ListCategoryCellDelegate?;
    
    //data
    var listCategory: [CategoryDTO] = [];

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib.init(nibName: "HomeCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(listCategory: [CategoryDTO]) {
        self.listCategory = listCategory;
        self.collectionView.reloadData();
    }
    
    // MARK: - Buttons Action
    @IBAction func btnSeeAllClicked(_ sender: Any) {
        self.delegate?.openSeeAllCategory();
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listCategory.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: HomeCategoryCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionCell", for: indexPath) as? HomeCategoryCollectionCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("HomeCategoryCollectionCell", owner: self, options: nil)?.first as? HomeCategoryCollectionCell;
        }
        if (self.listCategory.count > 0) {
            let catDTO = self.listCategory[indexPath.row];
            cell?.setData(categoryDTO: catDTO);
        }
        return cell!;
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryDTO = self.listCategory[indexPath.row];
        self.delegate?.openCategoryDetail(categoryDTO: categoryDTO);
    }
}
