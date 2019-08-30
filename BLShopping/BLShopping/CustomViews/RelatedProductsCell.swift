//
//  RelatedProductsCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

protocol RelatedProductsCellDelegate {
    func selectRelatedProduct(productDTO: ProductDTO);
}

class RelatedProductsCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listProducts: [ProductDTO] = [];
    
    var delegate: RelatedProductsCellDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.register(UINib(nibName: "BestSellerProductCell", bundle: nil), forCellWithReuseIdentifier: "BestSellerProductCell");
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(listProducts: [ProductDTO]) {
        self.listProducts = listProducts;
        
        self.collectionView.reloadData();
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listProducts.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: BestSellerProductCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSellerProductCell", for: indexPath) as? BestSellerProductCell;
        if (cell == nil) {
            if (checkIsIpad()) {
                cell = BestSellerProductCell(frame: CGRect(x: 0, y: 0, width: 200, height: 250));
            }
            else {
                cell = BestSellerProductCell(frame: CGRect(x: 0, y: 0, width: 140, height: 180));
            }
            
        }
        let productDTO = self.listProducts[indexPath.row];
        cell?.setData(productDTO: productDTO);
        return cell!;
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDTO = self.listProducts[indexPath.row];
        self.delegate?.selectRelatedProduct(productDTO: productDTO);
    }
}
