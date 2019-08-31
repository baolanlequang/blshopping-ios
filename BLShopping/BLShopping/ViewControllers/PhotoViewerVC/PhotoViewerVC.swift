//
//  PhotoViewerVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class PhotoViewerVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var collectViewSmall: UICollectionView!
    @IBOutlet weak var collectionViewLargeImage: UICollectionView!
    
    var listPhotos: [ProductPictureDTO]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectViewSmall.register(UINib(nibName: "PhotoViewerCell", bundle: nil), forCellWithReuseIdentifier: "PhotoViewerCell");
        
        self.collectViewSmall.reloadData();
        
        self.collectionViewLargeImage.register(UINib(nibName: "PhotoViewerLargeCell", bundle: nil), forCellWithReuseIdentifier: "PhotoViewerLargeCell");
        self.collectionViewLargeImage.reloadData();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Buttons Action
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.listPhotos != nil) {
            return (self.listPhotos?.count)!
        }
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.collectViewSmall) {
            var cell: PhotoViewerCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewerCell", for: indexPath) as? PhotoViewerCell;
            if (cell == nil) {
                cell = PhotoViewerCell(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
            }
            let photo = self.listPhotos?[indexPath.row];
            cell?.setData(photo: photo!);
            return cell!;
        }
        else {
            var cell: PhotoViewerLargeCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewerLargeCell", for: indexPath) as? PhotoViewerLargeCell;
            if (cell == nil) {
                cell = PhotoViewerLargeCell(frame: CGRect(x: 0, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height));
            }
            let photo = self.listPhotos?[indexPath.row];
            cell?.setData(photo: photo!);
            return cell!;
        }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.collectionViewLargeImage) {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height);
        }
        return CGSize(width: 50, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectViewSmall) {
            self.collectionViewLargeImage.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true);
            
            let cell: PhotoViewerCell = collectionView.cellForItem(at: indexPath) as! PhotoViewerCell;
            cell.updateBorder(isSelected: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (collectionView == self.collectViewSmall) {
            let cell: PhotoViewerCell = collectionView.cellForItem(at: indexPath) as! PhotoViewerCell;
            cell.updateBorder(isSelected: false)
        }
    }

}
