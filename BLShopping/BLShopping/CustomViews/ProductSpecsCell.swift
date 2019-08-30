//
//  ProductSpecsCell.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/30/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit

class ProductSpecsCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContainerDetail: UITableView!
    @IBOutlet weak var btnSeeAll: UIButton!
    
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    
    var currProductDTO: ProductDTO?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: set color
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(productDTO: ProductDTO) {
        self.currProductDTO = productDTO;
        
        let listSpecs = productDTO.listSpecs;
        if (listSpecs.count <= 4) {
            self.btnSeeAll.isHidden = true;
            self.buttonHeight.constant = 0;
        }
        else {
            self.btnSeeAll.isHidden = false;
            self.buttonHeight.constant = 44;
        }
        
        self.viewContainerDetail.reloadData();
//        self.viewContainerDetail.layoutIfNeeded();
//        self.viewContainerDetail.sizeToFit();
        
        //TODO: set height
        self.viewContainerHeight.constant = self.viewContainerDetail.contentSize.height;
        
    }
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.currProductDTO != nil) {
            let listSpecs = self.currProductDTO?.listSpecs;
            if ((listSpecs?.count)! <= 4) {
                return (listSpecs?.count)!;
            }
            else {
                return 4;
            }
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ProductSpectItemCell? = tableView.dequeueReusableCell(withIdentifier: "ProductSpectItemCell") as? ProductSpectItemCell;
        if (cell == nil) {
            cell = Bundle.main.loadNibNamed("ProductSpectItemCell", owner: self, options: nil)?.first as? ProductSpectItemCell;
        }
        
        if (self.currProductDTO != nil) {
            let specDTO = self.currProductDTO?.listSpecs[indexPath.row];
            if (specDTO != nil) {
                cell?.setData(specDTO: specDTO!)
            }
        }
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
    }
    
}
