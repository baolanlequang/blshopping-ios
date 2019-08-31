//
//  TopicDetailVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class TopicDetailVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var webView: UIWebView!
    var topicDTO: TopicDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = [];
        
        // Do any additional setup after loading the view.
        self.lblTitle.text = (self.topicDTO?.name)
        
        self.getTopicDetail();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Buttons Action
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    // MARK - CALL APIs
    func getTopicDetail() {
        //TODO: get topic detail
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestGetTopicDetail(topicID: (self.topicDTO?.ID)!) { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json["TopicDetailsResult"].dictionary != nil) {
//                    let result = json["TopicDetailsResult"];
//                    let body = result["Body"].stringValue;
//                    self.webView.loadHTMLString(body, baseURL: nil);
//                }
//            }
//            else {
//                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self);
//            }
//        }
    }
}
