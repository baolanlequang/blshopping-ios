//
//  SupportVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import MessageUI

protocol SupportVCDelegate {
    func onLoginSucceed();
}

class SupportVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SupportAccountCellDelegate, LoginSignupVCDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SupportVCDelegate?;
    
    var listTopics: [TopicDTO] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = [];
        
        self.getTopic();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return self.listTopics.count + 2;
        }
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            var cell: SupportAccountCell? = tableView.dequeueReusableCell(withIdentifier: "SupportAccountCell") as? SupportAccountCell;
            if (cell == nil) {
                cell = Bundle.main.loadNibNamed("SupportAccountCell", owner: self, options: nil)?.first as? SupportAccountCell;
                cell?.selectionStyle = .none;
            }
            cell?.delegate = self;
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
                cell?.accessoryType = .disclosureIndicator;
                cell?.selectionStyle = .none;
            }
            
            if (indexPath.row == 0) {
                cell?.textLabel?.text = "HOTLINE: 0908 265 711";
            }
            else if (indexPath.row == 1) {
                cell?.textLabel?.text = "Gửi email hỗ trợ";
            }
            else {
                let topicDTO = self.listTopics[indexPath.row - 2];
                cell?.textLabel?.text = topicDTO.name;
            }
            
            return cell!
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                if let url = NSURL(string: "tel://0908265711"), UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            else if (indexPath.row == 1) {
                self.sendMail();
            }
            else {
                let topicDTO = self.listTopics[indexPath.row - 2];
                let topicDetailVC = TopicDetailVC(nibName: "TopicDetailVC", bundle: nil);
                topicDetailVC.topicDTO = topicDTO;
                self.navigationController?.pushViewController(topicDetailVC, animated: true);
            }
        }
    }
    
    func sendMail() {
        if (MFMailComposeViewController.canSendMail()) {
            let mailer = MFMailComposeViewController();
            mailer.mailComposeDelegate = self;
            mailer.setSubject("Hỗ trợ app Vật Giá Sài Gòn");
            let toRecipients = ["vatgiasaigon.vn@gmail.com"];
            mailer.setToRecipients(toRecipients);
            self.present(mailer, animated: true, completion: nil);
        }
        else {
            showAlert(title: "Không thể gửi mail", message: "Thiết bị của bạn không hỗ trợ gửi mail hoặc vui lòng cài đặt tài khoản email trong ứng dụng email trước khi tiếp tục.", viewController: self);
        }
        
    }
    
    // MARK: - SupportAccountCellDelegate
    func didClickOpenLogin() {
        self.openLoginScreen()
    }
    
    func openLoginScreen() {
        let loginVC = LoginSignupVC(nibName: "LoginSignupVC", bundle: nil);
        let nav = UINavigationController(rootViewController: loginVC);
        loginVC.delegate = self;
        self.view.window?.rootViewController?.present(nav, animated: true, completion: nil);
    }
    
    // MARK: - LoginSignupVCDelegate
    func onBackClick() {
        
    }
    
    func onLoginSucceed() {
        self.delegate?.onLoginSucceed();
        _ = self.navigationController?.popViewController(animated: false);
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if (result == .saved) {
            showAlert(title: "", message: "Mail của bạn đã được gửi tới Vật Giá Sài Gòn. Vui lòng chờ một ít thời gian để chúng tôi hồi đáp!", viewController: self);
        }
        else if (result == .failed) {
            showAlert(title: "Không thể gửi mail", message: "Vui lòng kiểm tra lại tài khoản mail của bạn hoặc kết nối mạng internet.", viewController: self);
        }
        controller.dismiss(animated: true, completion: nil);
    }
    
    // MARK: - CALL APIs
    func getTopic() {
        //TODO: get list topic
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
//        requestGetListTopic { (operation, responseObject, error) in
//            hud.hide(animated: true);
//            if (error == nil) {
//                let json = JSON(responseObject ?? [:]);
//                if (json["TopicResult"].array != nil) {
//                    let result = json["TopicResult"].arrayValue;
//                    for jsonData in result {
//                        let topicDTO = TopicDTO(jsonData: jsonData);
//                        let filterArr = self.listTopics.filter({ (oldTopic) -> Bool in
//                            return oldTopic.ID == topicDTO.ID;
//                        })
//
//                        if (filterArr.count == 0) {
//                            self.listTopics.append(topicDTO);
//                        }
//                    }
//                    self.tableView.reloadData();
//
//                }
//            }
//        }
    }

}
