//
//  LoginSignupVC.swift
//  BLShopping
//
//  Created by Bao Lan Le Quang on 8/31/19.
//  Copyright © 2019 BLShopping. All rights reserved.
//

import UIKit
import MXSegmentedPager
import FBSDKCoreKit
import FBSDKLoginKit
import MBProgressHUD
import SwiftyJSON

protocol LoginSignupVCDelegate {
    func onBackClick();
    func onLoginSucceed();
}

class LoginSignupVC: MXSegmentedPagerController, LoginSignupHeaderViewDelegate, LoginViewDelegate, SignUpViewDelegate, GIDSignInUIDelegate {
    
    var headerView: LoginSignupHeaderView?;
    var delegate: LoginSignupVCDelegate?;
    var loginView: LoginView?;
    var signupView: SignUpView?;
    
    var isShowSignUp = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        
        self.headerView = Bundle.main.loadNibNamed("LoginSignupHeaderView", owner: self, options: nil)?.first as? LoginSignupHeaderView;
        self.headerView?.delegate = self;
        
        self.segmentedPager.backgroundColor = .white
        
        // Parallax Header
        self.segmentedPager.parallaxHeader.view = headerView
        self.segmentedPager.parallaxHeader.mode = .topFill
        self.segmentedPager.parallaxHeader.height = 150
        self.segmentedPager.parallaxHeader.minimumHeight = 0
        
        
        // Segmented Control customization
        self.segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        self.segmentedPager.segmentedControl.backgroundColor = UIColor.init(hexString: "f9f9f9");
        self.segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(hexString: "727272") ?? UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)];
        self.segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        self.segmentedPager.segmentedControl.selectionIndicatorColor = UIColor.init(hexString: "fdd835");
        self.segmentedPager.segmentedControl.borderType = .bottom;
        self.segmentedPager.segmentedControl.borderColor = UIColor.gray;
        self.segmentedPager.segmentedControl.borderWidth = 0.5;
        
        self.loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as? LoginView;
        self.loginView?.delegate = self;
        self.signupView = Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)?.first as? SignUpView;
        self.signupView?.delegate = self;
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if (self.isShowSignUp == true) {
            self.segmentedPager.pager.showPage(at: 1, animated: true);
        }
        else {
            self.segmentedPager.pager.showPage(at: 0, animated: true);
        }
    }
    
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return 2;
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["Đăng nhập", "Đăng ký"][index];
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index: Int) -> UIView {
        
        if (index == 0) {
            return self.loginView!;
        }
        else {
            return self.signupView!;
        }
    }
    
    // MARK: - LoginSignupHeaderViewDelegate
    func onClickBack() {
        self.delegate?.onBackClick();
        self.dismiss(animated: true) {
            
        }
    }
    
    
    // MAKR: - GIDSignInUIDelegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.navigationController?.present(viewController, animated: true, completion: nil);
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil);
    }
    
    // MARK: - LoginViewDelegate
    func didBtnLoginFacebookClicked() {
        if (FBSDKAccessToken.current() != nil) {
            self.getUserInfoFacebook();
        }
        else {
            let loginManager = FBSDKLoginManager();
            loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
                if (error != nil) {
                    
                }
                else if (result?.isCancelled)! {
                    
                }
                else {
                    self.getUserInfoFacebook();
                }
            }
        }
        
    }
    
    func didBtnLoginGoogleClicked() {
        GIDSignIn.sharedInstance().uiDelegate = self;
        GIDSignIn.sharedInstance().signIn();
    }
    
    func didBtnLoginClicked(email: String, password: String) {
        self.login(email: email, password: password);
    }
    
    // MARK: - SignUpViewDelegate
    func didBtnRegisterClicked(fullName: String, email: String, password: String) {
        self.signup(fullName: fullName, email: email, password: password);
    }
    
    // MARK: - CALL APIs
    func getUserInfoFacebook() -> Void {
        if (FBSDKAccessToken.current() != nil) {
            print("token: \(FBSDKAccessToken.current().tokenString)");
            let hub = MBProgressHUD.showAdded(to: self.view, animated: true);
            let parameters = ["fields":"id, name, email, picture, birthday"];
            FBSDKGraphRequest.init(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) in
                if (error != nil) {
                    hub.hide(animated: true)
                    print("FBSDKGraphRequest error: \(String(describing: error))");
                }
                else {
                    print("FBSDKGraphRequest result \(String(describing: result))");
                    let json = JSON.init(result ?? [:]);
                    let facebookID = json["id"].stringValue;
                    hub.hide(animated: true)
                    
                }
            })
        }
    }
    
    func login(email: String, password: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        requestLogin(email: email, password: password) { (operation, responseObject, error) in
            hud.hide(animated: true)
            if (error == nil) {
                let json = JSON(responseObject ?? [:])
                let status = json["status"]
                if (status["code"].intValue == 1) {
                    let data = json["data"]
                    let userDTO = UserDTO(jsonData: data)
                    BLGlobal.shared.userDTO = userDTO;
                    BLGlobal.shared.saveUser();
                    self.delegate?.onLoginSucceed();
                    self.dismiss(animated: true, completion: nil);
                    
                }
                else {
                    showAlert(title: "", message: status["msg"].stringValue, viewController: self)
                }
            }
            else {
                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self)
            }
        }
    }
    
    func signup(fullName: String, email: String, password: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        requestSignup(fullName: fullName, email: email, password: password) { (operation, responseObject, error) in
            hud.hide(animated: true)
            if (error == nil) {
                let json = JSON(responseObject ?? [:])
                let status = json["status"]
                if (status["code"].intValue == 1) {
                    let data = json["data"]
                    let userDTO = UserDTO(jsonData: data)
                    BLGlobal.shared.userDTO = userDTO;
                    BLGlobal.shared.saveUser();
                    self.delegate?.onLoginSucceed();
                    self.dismiss(animated: true, completion: nil);

                }
                else {
                    showAlert(title: "", message: status["msg"].stringValue, viewController: self)
                }
            }
            else {
                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self)
            }
        }
    }

    func loginByFacebook(facebookID: String, fullName: String, email: String, avatar: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        requestLoginByFacebook(facebookID: facebookID, fullName: fullName, email: email, avatar: avatar) { (operation, responseObject, error) in
            hud.hide(animated: true)
            if (error == nil) {
                let json = JSON(responseObject ?? [:])
                let status = json["status"]
                if (status["code"].intValue == 1) {
                    let data = json["data"]
                    let userDTO = UserDTO(jsonData: data)
                    BLGlobal.shared.userDTO = userDTO;
                    BLGlobal.shared.saveUser();
                    self.delegate?.onLoginSucceed();
                    self.dismiss(animated: true, completion: nil);
                    
                }
                else {
                    showAlert(title: "", message: status["msg"].stringValue, viewController: self)
                }
            }
            else {
                showAlert(title: "", message: (error?.localizedDescription)!, viewController: self)
            }
        }
    }
}
