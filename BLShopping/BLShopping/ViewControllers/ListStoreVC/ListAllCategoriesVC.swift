//
//  ListAllCategoriesVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/27/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ListAllCategoriesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //variables
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    //data
    var listCategory: [CategoryDTO]?
    var parentCategory: CategoryDTO?;

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = [];
        
        self.collectionView.register(UINib(nibName: "AllCategoriesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AllCategoriesCollectionCell")
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if (self.parentCategory != nil) {
            self.lblTitle.text = self.parentCategory?.name;
        }
        else {
            self.lblTitle.text = localizedString(key: "STR_LABEL_CATEGORY")
        }
    }

    // MARK: - Buttons Action
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.listCategory != nil) {
            if (self.parentCategory != nil) {
                return (self.listCategory?.count)! + 1;
            }
            return (self.listCategory?.count)!
        }
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: AllCategoriesCollectionCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCategoriesCollectionCell", for: indexPath) as? AllCategoriesCollectionCell;
        if (cell == nil) {
            if (checkIsIpad()) {
                cell = AllCategoriesCollectionCell(frame: CGRect(x: 0, y: 0, width: 384, height: 230));
            }
            else {
                cell = AllCategoriesCollectionCell(frame: CGRect(x: 0, y: 0, width: 160, height: 130));
            }
        }
        if (self.listCategory != nil) {
            if (self.parentCategory != nil) {
                if (indexPath.row == 0) {
                    cell?.setData(categoryDTO: nil);
                }
                else {
                    let catDTO = self.listCategory?[indexPath.row-1];
                    cell?.setData(categoryDTO: catDTO!);
                }
            }
            else {
                let catDTO = self.listCategory?[indexPath.row];
                cell?.setData(categoryDTO: catDTO!);
            }
            
        }
        return cell!;
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.parentCategory != nil) {
            if (((self.listCategory?.count)! + 1) % 2 != 0) {
                if (indexPath.row == (self.listCategory?.count)!) {
                    if (checkIsIpad()) {
                        return CGSize(width: collectionView.frame.size.width/2, height: 230);
                    }
                    return CGSize(width: collectionView.frame.size.width/2, height: 130);
                }
            }
        }
        else {
            if ((self.listCategory?.count)! % 2 != 0) {
                if (indexPath.row == (self.listCategory?.count)! - 1) {
                    if (checkIsIpad()) {
                        return CGSize(width: collectionView.frame.size.width/2, height: 230);
                    }
                    return CGSize(width: collectionView.frame.size.width/2, height: 130);
                }
            }
        }
        
        if (checkIsIpad()) {
            return CGSize(width: collectionView.frame.size.width/2, height: 230);
        }
        return CGSize(width: collectionView.frame.size.width/2, height: 130);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.parentCategory != nil) {
            if (indexPath.row == 0) {
                self.gotoListProduct(categoryDTO: self.parentCategory!);
            }
            else {
                let catDTO = self.listCategory?[indexPath.row-1];
                if ((catDTO?.listSubCat.count)! > 0) {
                    let listAllCategoriesVC = ListAllCategoriesVC(nibName: "ListAllCategoriesVC", bundle: nil);
                    listAllCategoriesVC.parentCategory = catDTO;
                    listAllCategoriesVC.listCategory = catDTO?.listSubCat;
                    self.navigationController?.pushViewController(listAllCategoriesVC, animated: true);
                }
                else {
                    self.gotoListProduct(categoryDTO: catDTO!);
                }
            }
        }
        else {
            let catDTO = self.listCategory?[indexPath.row];
            if ((catDTO?.listSubCat.count)! > 0) {
                let listAllCategoriesVC = ListAllCategoriesVC(nibName: "ListAllCategoriesVC", bundle: nil);
                listAllCategoriesVC.parentCategory = catDTO;
                listAllCategoriesVC.listCategory = catDTO?.listSubCat;
                self.navigationController?.pushViewController(listAllCategoriesVC, animated: true);
            }
            else {
                self.gotoListProduct(categoryDTO: catDTO!);
            }
        }
    }
    
    func gotoListProduct(categoryDTO: CategoryDTO) {
//        let listProductVC = ListProductVC(nibName: "ListProductVC", bundle: nil);
//        listProductVC.categoryDTO = categoryDTO;
//        self.navigationController?.pushViewController(listProductVC, animated: true);
    }

}
